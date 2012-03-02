package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.models.data.components.ComponentsContainerVO;
	import com.eguru.faje.mvcs.models.data.fsm.StateComponentSpecVO;
	import com.eguru.faje.mvcs.services.factories.IComponentFactory;
	import com.eguru.faje.mvcs.controllers.events.StateMachineEvent;
	import com.eguru.faje.mvcs.models.data.ComponentActivationSpecVO;
	import com.eguru.faje.mvcs.controllers.events.ComponentModelEvent;
	import org.robotlegs.mvcs.Actor;

	import com.eguru.faje.mvcs.models.IComponentModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ComponentModel extends Actor implements IComponentModel 
	{
		[Inject]
		public var assetModel : IAssetModel;
		
		[Inject]
		public var componentFactory : IComponentFactory;
		
		[Inject]
		public var displayPropertiesModel : IDisplayPropertiesModel;
		
		protected var _components : Vector.<ComponentVO>;
		protected var _waitingComponents : Vector.<ComponentVO>;
		protected var _activeComponents : Vector.<ComponentVO>;
		protected var _waitingActivationSpec : ComponentActivationSpecVO;
		protected var _waitingExitComponents : Vector.<ComponentVO>;
		
		public function ComponentModel() 
		{
			_components = new Vector.<ComponentVO>();
			_activeComponents = new Vector.<ComponentVO>();
		}

		public function AddComponent(dp : ComponentVO) : ComponentVO {
			if (ContainComponent(dp)) return dp;
			if (ContainComponentByName(dp.name)) throw new Error("The Display Property name '" + dp.name + "' is already assigned to an existing display properties object. Please rename one of them as names should be unique.");
			_components.push(dp);
			return dp;
		}
		
		public function AddComponentGroup(dps : Vector.<ComponentVO>) : void 
		{
			for each (var dp : ComponentVO in dps) 
			{
				AddComponent(dp);				
			}
		}

		public function RemoveComponent(dp : ComponentVO) : ComponentVO {
			if (!ContainComponent(dp)) return dp;
			_components.splice(_components.indexOf(dp), 1);
			return dp;
		}

		public function ContainComponent(dp : ComponentVO) : Boolean {
			return _components.indexOf(dp) != -1;
		}

		public function ContainComponentByName(name : String) : Boolean {
			for each (var i : ComponentVO in _components) {
				if (i.name == name) return true;
			}
			return false;
		}

		public function GetComponentByName(name : String) : ComponentVO {
			for each (var i : ComponentVO in _components) {
				if (i.name == name) return i;
			}
			throw new Error("Could not find the [Component: " + name + "]");
		}
		
		public function ActivateComponentsByStateSpec(enterComponentsSpecList : Vector.<StateComponentSpecVO>, exitComponentsSpecList : Vector.<StateComponentSpecVO>, activationSpec : ComponentActivationSpecVO = null) : void 
		{
			var enterComponentsList : Vector.<ComponentVO> = GetComponentsList(enterComponentsSpecList);
			var exitComponentsList : Vector.<ComponentVO> = GetComponentsList(exitComponentsSpecList);				
			trace("Activating " + enterComponentsList.length + " components | Deactivating " + exitComponentsList.length + " components");			
			ActivateComponents(enterComponentsList, exitComponentsList, activationSpec);
		}

		private function GetComponentsList(componentsSpecList : Vector.<StateComponentSpecVO>, addToThisVector : Vector.<ComponentVO> = null) : Vector.<ComponentVO> 
		{
			var componentsList : Vector.<ComponentVO> = addToThisVector == null ? new Vector.<ComponentVO>() : addToThisVector;
			for each (var spec : StateComponentSpecVO in componentsSpecList) 
			{		
				var component : ComponentVO = GetComponentByName(spec.componentName);
				if (component is ComponentsContainerVO)
				{
					var componentContainer : ComponentsContainerVO = component as ComponentsContainerVO;
					componentsList = GetComponentsList(componentContainer.componentsSpecifications, componentsList);
					continue;
				}
				
				componentsList.push(component);
				
				//Updates the display properties
				if (spec.displaySpecificationName != null && spec.displaySpecificationName != "")
				{
					component.SetDisplayProperties(displayPropertiesModel.GetDisplayPropertyByName(spec.displaySpecificationName));
				}
				else
				{
					component.SetDefaultPropertiesName();
				}
			}
			
			return componentsList;
		}
		
		public function ActivateComponentsByName(componentsNamesList : Vector.<String>, activationSpec : ComponentActivationSpecVO = null) : void 
		{
			var componentsList : Vector.<ComponentVO> = new Vector.<ComponentVO>();
			for each (var compName : String in componentsNamesList) {
				componentsList.push(GetComponentByName(compName));
			}
			ActivateComponents(componentsList, new Vector.<ComponentVO>(), activationSpec);
		}

		public function ActivateComponents(componentsList : Vector.<ComponentVO>, exitComponentsList : Vector.<ComponentVO>, activationSpec : ComponentActivationSpecVO = null) : void 
		{
			if ((componentsList == null || componentsList.length == 0) && (exitComponentsList == null || exitComponentsList.length == 0)) return;
			_waitingComponents = componentsList;
			_waitingExitComponents = exitComponentsList;
			_waitingActivationSpec = activationSpec;
			
			var evt : ComponentModelEvent;
			var c : ComponentVO;
			for each (c in _waitingComponents) {
				for each (var aN : String in c.assetsNames) {
					if (!assetModel.IsAssetLoadedByName(aN))
					{
						trace("Failed to activate components: some of the components assets are missing");
						evt = new ComponentModelEvent(ComponentModelEvent.MISSING_ASSETS, componentsList, activationSpec);
						dispatch(evt);
						return;
					}
				}
			}
			
			_waitingComponents = null;
			_waitingExitComponents = null;
			_waitingActivationSpec = null;
			
			var componentsAdded : Vector.<ComponentVO> = new Vector.<ComponentVO>();
			var componentsRemoved : Vector.<ComponentVO> = new Vector.<ComponentVO>();
			var componentsPersisted : Vector.<ComponentVO> = new Vector.<ComponentVO>();
			
			for each (c in componentsList) 
			{
				if (exitComponentsList.indexOf(c) == -1)
				{
					componentsAdded.push(c);
					_activeComponents.push(c);
				}
				else
				{
					componentsPersisted.push(c);
				}
			}
			
			for each (c in exitComponentsList) 
			{
				if (componentsList.indexOf(c) == -1)
				{
					componentsRemoved.push(c);
					_activeComponents.splice(_activeComponents.indexOf(c), 1);
				}
			}
			
			evt = new ComponentModelEvent(ComponentModelEvent.COMPONENTS_REMOVED, componentsRemoved, activationSpec);
			dispatch(evt);
			
			evt = new ComponentModelEvent(ComponentModelEvent.COMPONENTS_PERSISTED, componentsPersisted, activationSpec);
			dispatch(evt);
			
			evt = new ComponentModelEvent(ComponentModelEvent.COMPONENTS_ADDED, componentsAdded, activationSpec);
			dispatch(evt);
			
			evt = new ComponentModelEvent(ComponentModelEvent.COMPONENTS_CHANGED, _activeComponents, activationSpec);
			dispatch(evt);
			
			dispatch(new StateMachineEvent(StateMachineEvent.COMPONENTS_ACTIVATED_MESSAGE));
		}

		public function ResumeActivation() : void 
		{
			ActivateComponents(_waitingComponents, _waitingExitComponents, _waitingActivationSpec);
		}

		public function AddRawComponentGroup(componentsArray : Array) : Vector.<ComponentVO> 
		{
			var components : Vector.<ComponentVO> = new Vector.<ComponentVO>();
			for each (var c : Object in componentsArray) 
			{
				var componentVO : ComponentVO = componentFactory.GenerateComponentVO(c, this);
					
				for each (var assetName : String in componentVO.assetsNames) 
				{
					if (!assetModel.ContainAssetByName(assetName))
					throw  new Error("The [Component: " + componentVO.name + "]'s asset [Asset: " + assetName + "] was not found!");
				}
				
				components.push(componentVO);
				AddComponent(componentVO);
			}
			
			return components;
		}
	}
}
