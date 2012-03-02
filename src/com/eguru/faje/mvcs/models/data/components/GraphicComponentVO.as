package com.eguru.faje.mvcs.models.data.components {
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class GraphicComponentVO extends ComponentVO 
	{
		protected var _imageName : String;
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) :void
		{
			super.Initialize(specifications, models);
			
			_imageName = specifications["image"];
			
			assetsNames.push(_imageName);
		}
		
		public function get imageName() : String
		{
			return _imageName;
		}
	}
}
