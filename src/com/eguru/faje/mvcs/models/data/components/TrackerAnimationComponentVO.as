package com.eguru.faje.mvcs.models.data.components {
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TrackerAnimationComponentVO extends AnimationComponentVO 
	{
		private var _targetVarName : String;
		private var _defaultMaximum : Number;
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) : void
		{
			super.Initialize(specifications, models);
			
			_targetVarName = specifications["target"];
			
			_defaultMaximum = NaN;
			if (specifications.hasOwnProperty("defaultMaximum"))
			{
				_defaultMaximum = specifications["defaultMaximum"];
			}
			
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
