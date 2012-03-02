package com.eguru.faje.mvcs.models.data.components {
	import com.eguru.faje.mvcs.models.SoundModel;
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class SoundComponentVO extends ComponentVO {
		
		private static const SOUND_NAME_PROP : String = "sound";
		private static const LAYER_NAME_PROP : String = "layer";
		private static const VOLUME_PROP : String = "volume";
		private static const LOOPS_PROP : String = "loops";
		private static const START_TIME_PROP : String = "startTime";
		private static const STOP_MC_ON_STOP_PROP : String = "stopMCOnStop";
		
		protected var _soundName : String;
		protected var _layerName : String;
		protected var _startTime : Number;
		protected var _loops : int;
		protected var _volume : Number;
		protected var _stopMCOnStop : String;
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) :void
		{
			super.Initialize(specifications, models);
			
			_soundName = specifications[SOUND_NAME_PROP];
			
			_layerName = SoundModel.GLOBAL_SOUND_NAME;
			if (specifications.hasOwnProperty(LAYER_NAME_PROP))
			{
				_layerName = specifications[LAYER_NAME_PROP];
			}
			
			_volume = 1;
			if (specifications.hasOwnProperty(VOLUME_PROP))
			{
				_volume = specifications[VOLUME_PROP];
			}
			
			_loops = 1;
			if (specifications.hasOwnProperty(LOOPS_PROP))
			{
				_loops = specifications[LOOPS_PROP];
			}
			
			_startTime = 0;
			if (specifications.hasOwnProperty(START_TIME_PROP))
			{
				_startTime = specifications[START_TIME_PROP] * 1000;
			}
			
			_stopMCOnStop = null;
			if (specifications.hasOwnProperty(STOP_MC_ON_STOP_PROP))
			{
				_stopMCOnStop = specifications[STOP_MC_ON_STOP_PROP];
			}
			
			assetsNames.push(_soundName);
		}
		
		public function get soundName() : String
		{
			return _soundName;
		}
		
		public function get layerName() : String
		{
			return _layerName;
		}
		
		public function get volume() : Number
		{
			return _volume;
		}
		
		public function get loops() : int
		{
			return _loops;
		}
		
		public function get startTime() : Number
		{
			return _startTime;
		}
		
		public function get stopMCOnStop() : String
		{
			return _stopMCOnStop;
		}
	}
}
