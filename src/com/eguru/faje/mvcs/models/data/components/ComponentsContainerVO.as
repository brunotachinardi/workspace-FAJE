package com.eguru.faje.mvcs.models.data.components {
	import com.eguru.faje.mvcs.models.data.fsm.StateComponentSpecVO;
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ComponentsContainerVO extends ComponentVO 
	{
		protected var _componentsSpecifications : Vector.<StateComponentSpecVO>;
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) : void
		{
			super.Initialize(specifications, models);
			
			_componentsSpecifications = new Vector.<StateComponentSpecVO>();
			for each (var spec : Object in specifications["components"]) 
			{
				_componentsSpecifications.push(new StateComponentSpecVO(spec));
			}
		}
		
		public function get componentsSpecifications() : Vector.<StateComponentSpecVO>
		{
			return _componentsSpecifications;
		}
	}
}
