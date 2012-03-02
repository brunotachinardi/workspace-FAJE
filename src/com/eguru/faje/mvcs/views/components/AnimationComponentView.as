package com.eguru.faje.mvcs.views.components 
{
	
	import com.eguru.faje.mvcs.models.data.components.SoundComponentVO;
	import com.eguru.faje.mvcs.models.data.components.AnimationSoundVO;
	import com.greensock.easing.Linear;
	import flash.media.SoundMixer;
	import com.greensock.plugins.FramePlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import com.eguru.faje.mvcs.models.data.components.AnimationComponentVO;
	import com.eguru.faje.mvcs.views.components.events.AnimationComponentViewEvent;
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.views.components.GraphicComponentView;

	/**
	 * @author Bruno Tachinardi
	 */
	public class AnimationComponentView extends GraphicComponentView {
		
		protected var _animationVO : AnimationComponentVO;
		protected var _animatedMC : MovieClip;
		protected var _tween : TweenLite;		
		protected var _sounds : Vector.<SoundComponentView>;
		protected var _lastFrame : int;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			TweenPlugin.activate([FramePlugin]);
			super.Initialize(componentVO, assets);
			_animationVO = componentVO as AnimationComponentVO;

			if (_image is DisplayObjectContainer)
			{
				_animatedMC = SearchForNamedMC(_image as DisplayObjectContainer, _animationVO.animationName);			
				if (_animatedMC == null) _animatedMC = SearchForAnimatedMC(_image as DisplayObjectContainer);			
			}
			
			if (_animatedMC != null)
			{
				StartAnimation(_animatedMC);
			}
			
			addEventListener(Event.ENTER_FRAME, Update);
			
			_sounds = new Vector.<SoundComponentView>();
			for each (var sound : AnimationSoundVO in _animationVO.sounds) 
			{
				var soundView : SoundComponentView = new SoundComponentView();
				soundView.Initialize(sound.soundVO, _assets);
				_sounds.push(soundView);
			}
		}

		private function GetAnimationDuration(target : MovieClip, fps : int) : Number 
		{
			return target.totalFrames / fps;
		}
		
		

		protected function SearchForAnimatedMC(image : DisplayObjectContainer) : MovieClip 
		{
			if (image != null && image is MovieClip && MovieClip(image).totalFrames > 1) return image as MovieClip;
			for (var i : int = 0; i < image.numChildren; i++) 
			{
				var child : DisplayObject = image.getChildAt(i);
				if (child is DisplayObjectContainer)
				{
					var result : MovieClip = SearchForAnimatedMC(child as DisplayObjectContainer);
					if (result != null) return result;
				}
			}
			return null;
		}

		protected function Update(event : Event) : void 
		{
				
			if (_animatedMC != null)
			{
				for each (var sound : AnimationSoundVO in _animationVO.sounds) 
				{
					if (sound.frame > _lastFrame &&  sound.frame <= _animatedMC.currentFrame)
					{
						var soundView : SoundComponentView = GetSoundView(sound.soundVO);
						soundView.Enter(.25);
						addChild(soundView);
					}
				}
				
				_lastFrame = _animatedMC.currentFrame;
				if (_animatedMC.currentFrame != _animatedMC.totalFrames) return;
				if (_animationVO.loop)
				{
					StartAnimation(_animatedMC);
				}
				else 
				{
					_animatedMC.stop();				
					removeEventListener(Event.ENTER_FRAME, Update);
				}
				
				dispatchEvent(new AnimationComponentViewEvent(AnimationComponentViewEvent.ANIMATION_END, _animationVO.endEvent));
			}
			else
			{				
				_animatedMC = SearchForNamedMC(_image as DisplayObjectContainer, _animationVO.animationName);			
				if (_animatedMC == null) _animatedMC = SearchForAnimatedMC(_image as DisplayObjectContainer);
				if (_animatedMC != null)
				{
					StartAnimation(_animatedMC);
				}
			}
		}

		private function GetSoundView(soundVO : SoundComponentVO) : SoundComponentView 
		{
			for each (var soundView : SoundComponentView in _sounds) {
				if (soundView.vo == soundVO) return soundView;
			}
			return null;
		}

		private function StartAnimation(target : MovieClip, delay : Number = 0) : void 
		{
			target.gotoAndStop(0);
			_lastFrame = 0;
			_tween = TweenLite.to(target, GetAnimationDuration(target, _animationVO.fps), {frame : _animatedMC.totalFrames, ease : Linear.easeNone, delay : delay});
		}
		
		override public virtual function Enter(time : Number) : void
		{
			if (_animatedMC != null) 
			{
				StartAnimation(_animatedMC, time);
			}
		}
		
		override public virtual function Exit(time : Number) : void
		{
			if (_animatedMC != null) 
			{
				if (_tween != null) _tween.pause();
				SoundMixer.stopAll();
				for each (var sound : SoundComponentView in _sounds) 
				{
					if (contains(sound)) removeChild(sound);
					sound.Exit(time);
				}
			}
		}
		
		
	}
}
