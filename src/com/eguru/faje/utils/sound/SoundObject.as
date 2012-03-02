package com.eguru.faje.utils.sound {
	import flash.utils.getQualifiedClassName;
	import com.eguru.faje.utils.sound.events.SoundObjectEvent;
	import com.eguru.faje.utils.sound.core.ISoundObjectContainer;
	import com.eguru.faje.utils.sound.core.ISoundObject;
	import flash.events.EventDispatcher;
	import com.greensock.plugins.VolumePlugin;
	import com.greensock.plugins.TweenPlugin;
	import flash.media.SoundChannel;
	import flash.events.ProgressEvent;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import com.greensock.TweenLite;
	import flash.events.Event;
	import flash.media.SoundTransform;
	
	/**
 	 * @author Bruno Tachinardi
 	 */
	public class SoundObject extends EventDispatcher implements ISoundObject
	{
		protected var _sound : Sound;
		protected var _channel : SoundChannel;
		protected var _fadeTween : TweenLite;
		protected var _volume : Number;
		protected var _name : String;
		protected var _position : int;
		protected var _paused : Boolean;
		protected var _savedVolume : Number;
		protected var _startTime : Number;
		protected var _loops : int;
		protected var _pausedByAll : Boolean;
		protected var _muted : Boolean;
		protected var _parent : ISoundObjectContainer;
		
		private var _settingParent : Boolean;

		public function SoundObject(name : String, sound : Sound):void		{			super();
			TweenPlugin.activate([VolumePlugin]);
			_sound = sound;
			_position = 0;
			_startTime = 0;
			_loops = 0;
			_channel = new SoundChannel();
			_name = name;
			_paused = true;
			_volume = 1;		}

		public function Play(startTime : Number = 0, loops : int = 0, volume : Number = 1, resumeTween : Boolean = true) : void		{
			if (resumeTween && (_fadeTween != null)) _fadeTween.resume();
			SetVolume(volume);
			_startTime = startTime;
			_loops = loops;
			_position = (_startTime == 0) ? _position : _startTime;
			if (!_paused || _sound == null) return;
			_paused = false;
			_channel = _sound.play(_position, _loops, new SoundTransform(realVolume));
			_channel.addEventListener(Event.SOUND_COMPLETE, HandleSoundComplete);					}

		public function Pause(pauseTween : Boolean = true) : void
		{
			_paused = true;
			if (pauseTween && (_fadeTween != null)) _fadeTween.pause();
			
			if (_sound == null) return;	
					
			_position = _channel.position;
			_channel.stop();
			_channel.removeEventListener(Event.SOUND_COMPLETE, HandleSoundComplete);			
		}

		public function Stop() : void
		{
			_paused = true;
			_fadeTween = null;
			
			if (_sound == null) return;
			
			_channel.stop();
			_channel.removeEventListener(Event.SOUND_COMPLETE, HandleSoundComplete);
			_position = _channel.position;
		}

		public function Fade(volume : Number = 0, fadeLength : Number = 1, stopOnComplete : Boolean = false) : void
		{
			_volume = volume;
			_fadeTween = TweenLite.to(_channel, fadeLength, {volume: realVolume, onComplete: FadeComplete, onCompleteParams: [stopOnComplete]});
		}
		
		public function SetVolume(volume : Number) : void
		{
			if (_volume == volume) return;
			_volume = volume;
			UpdateVolume();
		}
		
		private function UpdateVolume() : void 
		{
			if (_sound == null) return;
			_channel.soundTransform.volume = realVolume;
		}
		
		public function SetMuted(value : Boolean) : void
		{
			if (value == _muted) return;
			if (value)
			{
				Mute();
			}
			else
			{
				Unmute();
			}
		}
		
		public function Mute() : void 
		{
			_muted = true;
			UpdateVolume();
		}

		public function Unmute() : void 
		{
			_muted = false;
			UpdateVolume();
		}
		
		public function SetFadeTween(value : TweenLite) : void
		{
			if (value == null) TweenLite.killTweensOf(this);			
			_fadeTween = value;
		}
		
		public function AddSoundListeners(onSoundLoadComplete : Function, onSoundLoadProgress : Function, onSoundLoadError : Function) : void
		{
			_sound.addEventListener(IOErrorEvent.IO_ERROR, onSoundLoadError);
			_sound.addEventListener(ProgressEvent.PROGRESS, onSoundLoadProgress);
			_sound.addEventListener(Event.COMPLETE, onSoundLoadComplete);	
		}
		
		public function RemoveSoundListeners(onSoundLoadError : Function, onSoundLoadProgress : Function, onSoundLoadComplete : Function) : void
		{
			_sound.removeEventListener(IOErrorEvent.IO_ERROR, onSoundLoadError);
			_sound.removeEventListener(ProgressEvent.PROGRESS, onSoundLoadProgress);
			_sound.removeEventListener(Event.COMPLETE, onSoundLoadComplete);	
		}
		
		public function Dispose() : void
		{
			_sound = null;
			_channel.removeEventListener(Event.SOUND_COMPLETE, HandleSoundComplete);
			_channel = null;
			_fadeTween = null;
		}

		private function FadeComplete(stopOnComplete : Boolean) : void
		{
			if (stopOnComplete) Stop();
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_FADE_COMPLETE, this));
		}

		private function HandleSoundComplete(event : Event) : void
		{
			Stop();			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_PLAY_COMPLETE, this));
		}	
		
		public function get sound() : Sound 
		{ 
			return _sound; 
		}
		
		public function get channel() : SoundChannel 
		{ 
			return _channel; 
		}
		
		public function get volume() : Number
		{
		    return _volume;
		}
		
		public function get fadeTween() : TweenLite
		{
		    return _fadeTween;
		}	
		
		public function get name() : String 
		{ 
			return _name; 
		}
		
		public function get position() : int 
		{ 
			return _position; 
		}
		
		public function get paused() : Boolean 
		{ 
			return _paused; 
		}
		
		public function get startTime() : Number 
		{
			return _startTime; 
		}
		
		public function get loops() : int 
		{ 
			return _loops; 
		}
		
		public function get pausedByParent() : Boolean 
		{ 
			return _parent != null && _parent.paused; 
		}
		
		public function get muted() : Boolean 
		{ 
			return _muted; 
		}
		
		override public function toString() : String
		{
			return getQualifiedClassName(this);
		}

		public function get parent() : ISoundObjectContainer 
		{
			return _parent;
		}

		public function get realVolume() : Number 
		{
			if (_muted) return 0;
			if (_parent == null) return _volume;
			return _volume * _parent.realVolume;
		}

		public function set parent(value : ISoundObjectContainer) : void 
		{
			if (_settingParent) return;
			_settingParent = true;
			
			if (_parent != null)
			{
				_parent.RemoveSound(this);
			}
			
			_parent = value;
			
			if (_parent != null && !_parent.Contains(this)) _parent.AddSound(this);
			
			_settingParent = false;
		}

		public function get duration() : Number
		{
			return _sound.length;
		}
	}
}