package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.mvcs.views.components.events.StopAnimationEvent;
	import com.eguru.faje.utils.sound.events.SoundObjectEvent;
	import com.eguru.faje.utils.sound.core.ISoundObject;
	import com.eguru.faje.mvcs.models.ISoundModel;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.models.data.components.SoundComponentVO;
	import com.eguru.faje.mvcs.views.components.core.ComponentView;

	/**
	 * @author Bruno Tachinardi
	 */
	public class SoundComponentView extends ComponentView {
		
		protected var _soundVO : SoundComponentVO;
		protected var _sound : ISoundObject;
		protected var _soundModel : ISoundModel;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			super.Initialize(componentVO, assets);
			_soundVO = componentVO as SoundComponentVO;
			_sound = GetSound(assets, _soundVO.soundName, _soundVO.layerName);		
			_sound.addEventListener(SoundObjectEvent.SOUND_OBJECT_PLAY_COMPLETE, HandleSoundComplete);		
		}

		private function HandleSoundComplete(event : SoundObjectEvent) : void 
		{
			if (_soundVO.stopMCOnStop != null) 
			{
				dispatchEvent(new StopAnimationEvent(StopAnimationEvent.STOP_ANIMATION, _soundVO.stopMCOnStop));
			}
		}
		
		override public function Enter(time : Number) : void 
		{
			_sound.Play(_soundVO.startTime, _soundVO.loops, 0, false);
			_sound.Fade(_soundVO.volume, time, false);
		}

		override public function Exit(time : Number) : void 
		{
			_sound.Fade(0, time, true);
		}
	}
}
