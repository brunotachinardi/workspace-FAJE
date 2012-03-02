package com.eguru.faje.mvcs.services.factories {
	import com.eguru.faje.mvcs.models.IComponentModel;
	import com.eguru.faje.mvcs.views.components.core.ComponentView;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IComponentFactory
	{
		function GenerateComponentVO(specifications : Object, componentModel : IComponentModel) : ComponentVO;
		function GenerateComponentView(componentVO : ComponentVO, isPersisting : Boolean = false) : ComponentView;
		function MapComponent(componentName : String, componentVOClass : Class, componentViewClass : Class = null) : void;
	}
}
