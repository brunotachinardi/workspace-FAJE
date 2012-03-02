package com.eguru.faje.mvcs.models.data.components {
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public class AnimationSoundVO 
	{
		protected var _soundVO : SoundComponentVO;
		protected var _frame : Number;

		public function AnimationSoundVO(spec : Object, models : SpecificationsModelsVO)
		{
			_frame = spec["frame"];
			_soundVO = new SoundComponentVO();
			_soundVO.Initialize(spec, models);
		}
		
		public function get soundVO() : SoundComponentVO
		{
			return _soundVO;
		}
		
		public function get frame() : Number
		{
			return _frame;
		}
	}
}
