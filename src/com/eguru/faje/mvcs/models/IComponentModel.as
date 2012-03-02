package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.models.data.fsm.StateComponentSpecVO;
	import com.eguru.faje.mvcs.models.data.ComponentActivationSpecVO;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IComponentModel 
	{
		function AddComponent(component : ComponentVO) : ComponentVO;
		function AddComponentGroup(components : Vector.<ComponentVO>) : void;
		function AddRawComponentGroup(componentsArray : Array) : Vector.<ComponentVO>;
		function RemoveComponent(component : ComponentVO) : ComponentVO;
		function ContainComponent(component : ComponentVO) : Boolean;
		function ContainComponentByName(name : String) : Boolean;
		function GetComponentByName(name : String) : ComponentVO;
		
		function ActivateComponentsByStateSpec(enterComponentsSpecList : Vector.<StateComponentSpecVO>, exitComponentsSpecList : Vector.<StateComponentSpecVO>, activationSpec : ComponentActivationSpecVO = null) : void;
		function ActivateComponentsByName(componentsNamesList : Vector.<String>, activationSpec : ComponentActivationSpecVO = null) : void;
		function ActivateComponents(componentsList : Vector.<ComponentVO>, exitComponentsList : Vector.<ComponentVO>, activationSpec : ComponentActivationSpecVO = null) : void;
		function ResumeActivation() : void;
	}
}
