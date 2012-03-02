package com.eguru.faje.mvcs.models.data.components {
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TrackerBarComponentVO extends ComponentVO 
	{		
		private var _barImageName : String;
		private var _backgroundImageName : String;
		private var _borderImageName : String;
		private var _targetVarName : String;
		private var _defaultMaximum : Number;
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) : void
		{
			super.Initialize(specifications, models);
			
			_barImageName = specifications["bar"];
			assetsNames.push(_barImageName);
			
			_backgroundImageName = null;
			if (specifications.hasOwnProperty("bg"))
			{
				_backgroundImageName = specifications["bg"];
				assetsNames.push(_backgroundImageName);
			}
			
			_borderImageName = null;	
			if (specifications.hasOwnProperty("border"))
			{
				_borderImageName = specifications["border"];
				assetsNames.push(_borderImageName);
			}
					
			_targetVarName = specifications["target"];
			
			_defaultMaximum = NaN;
			if (specifications.hasOwnProperty("defaultMaximum"))
			{
				_defaultMaximum = specifications["defaultMaximum"];
			}
			
			
			
			
		}
		
		public function get barImageName() : String
		{
			return _barImageName;
		}
		
		public function get backgroundImageName() : String
		{
			return _backgroundImageName;
		}
		
		public function get borderImageName() : String
		{
			return _borderImageName;
		}
		
		public function get targetVarName() : String
		{
			return _targetVarName;
		}
		
		public function get defaultMaximum() : Number
		{
			return _defaultMaximum;
		}
	}
}
