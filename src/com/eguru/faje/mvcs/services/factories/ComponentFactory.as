package com.eguru.faje.mvcs.services.factories {
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.models.IComponentModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentsBehaviours;
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.eguru.faje.mvcs.models.ITextPropertiesModel;
	import com.eguru.faje.mvcs.models.IDisplayPropertiesModel;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentMap;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import org.robotlegs.mvcs.Actor;
	import com.eguru.faje.mvcs.views.components.core.ComponentView;
	/**
	 * @author Bruno Tachinardi
	 */
	public class ComponentFactory extends Actor implements IComponentFactory {
		
		[Inject]
		public var assets : IAssetModel;
		
		[Inject]
		public var displayPropertiesModel : IDisplayPropertiesModel;
		
		[Inject]
		public var textPropertiesModel : ITextPropertiesModel;
		
		[Inject]
		public var varsModel : IAppNumberVariableModel;
		
		[Inject]
		public var textModel : ITextsModel;
		
		protected var _componentsViewsInstances : Vector.<ComponentView>;
		
		protected var _maps : Vector.<ComponentMap>;
		
		
		public function ComponentFactory() {
			_componentsViewsInstances = new Vector.<ComponentView>();
			_maps = new Vector.<ComponentMap>();
		}
		
		public function MapComponent(componentName : String, componentVOClass : Class, componentViewClass : Class = null) : void
		{
			for each (var map : ComponentMap in _maps) {
				if (map.name == componentName) throw new Error("This component name is already mapped!");
				if (map.voClass == componentVOClass) throw new Error("This component VO class is already mapped!");
				if (map.viewClass == componentViewClass) throw new Error("This component view class is already mapped!");			
			}
			
			_maps.push(new ComponentMap(componentName, componentVOClass, componentViewClass));	
		}
		
		public function GenerateComponentVO(specifications : Object, componentModel : IComponentModel) : ComponentVO
		{
			var map : ComponentMap = GetMapByName(specifications["type"] as String);
			var componentVO : ComponentVO = new map.voClass() as ComponentVO;
			componentVO.Initialize(specifications["spec"], new SpecificationsModelsVO(displayPropertiesModel, textPropertiesModel, componentModel, varsModel, textModel));			
			return componentVO;
		}
	

		public function GenerateComponentView(componentVO : ComponentVO, isPersisting : Boolean = false) : ComponentView 
		{
			//Checks if an instance for this component already exists, if it does, return it
			var componentView : ComponentView;
			if ((componentVO.behaviour == ComponentsBehaviours.STRONG) ||
				(isPersisting && componentVO.behaviour == ComponentsBehaviours.PERSISTENT))
				
			{
				for each (componentView in _componentsViewsInstances) 
				{
					if (componentView.vo == componentVO) 
					{
						return componentView;
					}
				}
			}
			
			
			var map : ComponentMap = GetMapByVO(getDefinitionByName(getQualifiedClassName(componentVO)) as Class);
			componentView = new map.viewClass() as ComponentView;
			componentView.Initialize(componentVO, assets);			
			_componentsViewsInstances.push(componentView);
			return componentView;
		}
		
		private function GetMapByName(name : String) : ComponentMap {
			for each (var map : ComponentMap in _maps) {
				if (map.name == name) return map;
			}
			throw new Error("The component name '" + name + "' was not mapped!");
		}
		
		private function GetMapByVO(vo : Class) : ComponentMap {
			for each (var map : ComponentMap in _maps) {
				if (map.voClass == vo) return map;
			}
			throw new Error("The component vo class " + vo + " was not mapped!");
		}
	}
}
