package com.eguru.faje.utils.sound {
	import com.eguru.faje.utils.sound.events.SoundObjectEvent;
	import com.eguru.faje.utils.sound.core.ISoundObjectContainer;
	import com.eguru.faje.utils.sound.core.ISoundObject;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundLoaderContext;
	import flash.net.URLRequest;
	import flash.utils.getQualifiedClassName;
	
	public class SoundObjectContainer extends SoundObject implements ISoundObjectContainer
	{
		protected var _sounds : Vector.<ISoundObject>;
		protected var _tempExternalSoundItem : ISoundObject;
		private var _changingChildren : Boolean;
		
		public function SoundObjectContainer(name : String) 
		{
			super(name, null);
			_sounds = new Vector.<ISoundObject>();
		}
		
		private function AddAnySound(linkageID : *, preloadedSound : Sound, path : String, name : String, buffer : Number = 1000, checkPolicyFile : Boolean = false) : ISoundObject
		{

			var length : int = _sounds.length;
			
			for (var i : int = 0; i < length; i++)
			{
				if ((_sounds[i] as ISoundObject).name == name) return null;
			}

			var sound : Sound;
			var soundItem : SoundObject;
			
			if (linkageID == null)
			{
				if (preloadedSound == null)
				{
					sound = new Sound(new URLRequest(path), new SoundLoaderContext(buffer, checkPolicyFile));
					
					soundItem = new SoundObject(name, sound);
					soundItem.AddSoundListeners(OnSoundLoadComplete, OnSoundLoadProgress, OnSoundLoadError);
					_tempExternalSoundItem = soundItem;
				}
				else
				{
					soundItem = new SoundObject(name, preloadedSound);
				}
			}
			else
			{
				soundItem = new SoundObject(name, new linkageID);
			}
			
			return AddSound(soundItem);	
		}
		
		public function AddLibrarySound(linkageID : *, name : String) : ISoundObject
		{
			return AddAnySound(linkageID, null, "", name);
		}		
		
		public function AddExternalSound(path : String, name : String, buffer : Number = 1000, checkPolicyFile : Boolean = false) : ISoundObject
		{
			return AddAnySound(null, null, path, name, buffer, checkPolicyFile);
		}
		
		public function AddPreloadedSound(sound : Sound, name : String) : ISoundObject
		{
			return AddAnySound(null, sound, "", name);
		}
		
		public function AddSound(soundItem : ISoundObject) : ISoundObject
		{
			if (_changingChildren) return null;
			_changingChildren = true;
			
			if (soundItem == null || Contains(soundItem)) return null;
			
			soundItem.SetVolume((_muted) ? 0 : 1);
			soundItem.SetMuted(_muted);
			soundItem.addEventListener(SoundObjectEvent.SOUND_OBJECT_PLAY_COMPLETE, HandleSoundPlayComplete);
			
			_sounds.push(soundItem);
			
			soundItem.parent = this;
			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_ADDED, soundItem));		
			_changingChildren = false;	
			return soundItem;
		}

		public function Contains(soundItem : ISoundObject) : Boolean 
		{
			return _sounds.indexOf(soundItem) != -1;
		}
		
		public function GetSound(name : String) : ISoundObject 
		{
			for each (var soundItem : ISoundObject in _sounds) 
			{
				if (soundItem.name == name) return soundItem;
			}
			return null;
		}
		
		public function RemoveSoundByName(name : String) : Boolean
		{
			return RemoveSound(GetSound(name));			
		}
		
		public function RemoveSound(soundItem : ISoundObject) : Boolean
		{
			if (_changingChildren) return false;
			_changingChildren = true;
			
			if (soundItem is SoundObject) SoundObject(soundItem).RemoveSoundListeners(OnSoundLoadComplete, OnSoundLoadProgress, OnSoundLoadError);
			soundItem.removeEventListener(SoundObjectEvent.SOUND_OBJECT_PLAY_COMPLETE, HandleSoundPlayComplete);
			soundItem.Dispose();
			
			var index : int = _sounds.indexOf(soundItem);
			if (index == -1) return false;
			_sounds.splice(index, 1);
			
			soundItem.parent = null;
			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_REMOVED, soundItem));
			_changingChildren = false;
			return true;
		}
		
		
		public function RemoveAllSounds():void
		{
			var lenght : int = _sounds.length;			
			for (var i : int = 0; i < lenght; i++)
			{
				RemoveSound(_sounds[i]);
			}
			
			_sounds = new Vector.<ISoundObject>();			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.REMOVED_ALL));
		}

		public function PlaySound(name : String, volume : Number = 1, startTime : Number = 0, loops : int = 0, resumeTween : Boolean = true) : void
		{
			var soundItem : ISoundObject = GetSound(name);
			soundItem.Play(startTime, loops, volume, resumeTween);			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_PLAY_START, soundItem));
		}

		public function PauseSound(name : String, pauseTween : Boolean = true) : void
		{
			var soundItem : ISoundObject = GetSound(name);
			soundItem.Pause(pauseTween);			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_PAUSE, soundItem));
		}
		
		public function StopSound(name : String) : void
		{
			var soundItem : ISoundObject = GetSound(name);
			soundItem.Stop();			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_STOP, soundItem));
		}

		override public function Play(startTime : Number = 0, loops : int = 0, volume : Number = 1, resumeTween : Boolean = true) : void
		{
			super.Play(startTime, loops, volume, resumeTween);
			var lenght : int = _sounds.length;			
			for (var i : int = 0; i < lenght; i++)
			{
				PlaySound(_sounds[i].name, volume, startTime, loops, resumeTween);
			}			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.PLAY_ALL));
		}
		
		override public function Pause(pauseTween : Boolean = true) : void
		{
			super.Pause(pauseTween);
			var lenght : int = _sounds.length;			
			for (var i : int = 0; i < lenght; i++)
			{
				PauseSound(_sounds[i].name, pauseTween);
			}			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.PAUSE_ALL));
		}
		
		override public function Stop() : void
		{
			super.Stop();
			var lenght : int = _sounds.length;
			for (var i : int = 0; i < lenght; i++)
			{
				StopSound(_sounds[i].name);
			}			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.STOP_ALL));
		}
		
		public function FadeSound(name : String, volume : Number = 0, fadeLength : Number = 1, stopOnComplete : Boolean = false) : void
		{
			var soundItem : ISoundObject = GetSound(name);
			soundItem.addEventListener(SoundObjectEvent.SOUND_OBJECT_FADE_COMPLETE, HandleFadeComplete);
			soundItem.Fade(volume, fadeLength, stopOnComplete);			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_FADE, soundItem));
		}
		
		override public function Fade(volume : Number = 0, fadeLength : Number = 1, stopOnComplete : Boolean = false) : void
		{
			var lenght : int = _sounds.length;
			for (var i : int = 0; i < lenght; i++)
			{
				FadeSound(_sounds[i].name, volume, fadeLength, stopOnComplete);
			}
			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.FADE_ALL));
		}
		
		public function MuteSound(name : String) : void
		{
			var soundItem : ISoundObject = GetSound(name);
			soundItem.Mute();			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_MUTE, soundItem));
		}
		
		public function UnmuteSound(name : String) : void
		{
			var soundItem : ISoundObject = GetSound(name);
			soundItem.Unmute();			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_UNMUTE, soundItem));
		}		

		override public function Mute():void
		{
			super.Mute();			
			var length : int = _sounds.length;
			for (var i : int = 0; i < length; i++)
			{
				MuteSound(_sounds[i].name);
			}
			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.MUTE_ALL));
		}
		
		override public function Unmute():void
		{
			super.Unmute();			
			var length : int = _sounds.length;
			for (var i : int = 0; i < length; i++)
			{
				UnmuteSound(_sounds[i].name);
			}
			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.UNMUTE_ALL));
		}
		
		
		public function SetSoundVolume(name : String, volume : Number) : void
		{
			GetSound(name).SetVolume(volume);
		}
		
		public function GetSoundVolume(name : String) : Number
		{
			return GetSound(name).volume;
		}
		
		public function GetSoundPosition(name : String) : int
		{
			return GetSound(name).position;
		}
		
		public function GetSoundDuration(name : String) : Number
		{
			return GetSound(name).duration;
		}

		public function IsSoundPaused(name : String) : Boolean
		{
			return GetSound(name).paused;
		}
		
		
		public function IsSoundPausedByParent(name : String) : Boolean
		{
			return GetSound(name).pausedByParent;
		}
	
		private function OnSoundLoadError(event : IOErrorEvent) : void
		{
			_tempExternalSoundItem = null;
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_LOAD_ERROR));
		}
		
		private function OnSoundLoadProgress(event : ProgressEvent) : void
		{
			var percent : uint = Math.round(100 * (event.bytesLoaded / event.bytesTotal));
			var sound : Sound = (event.target as Sound);
			var duration : Number = 0;
			
			if (sound != null && sound.length > 0)
			{
			    duration = ((sound.bytesTotal / (sound.bytesLoaded / sound.length)) * .001);
			}
			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_LOAD_PROGRESS, _tempExternalSoundItem, duration, percent));
		}

		private function OnSoundLoadComplete(event : Event) : void
		{
			var sound : Sound = (event.target as Sound);
			var duration : Number = (sound.length * .001);
			
			dispatchEvent(new SoundObjectEvent(SoundObjectEvent.SOUND_OBJECT_LOAD_COMPLETE, _tempExternalSoundItem, duration));
			
			_tempExternalSoundItem = null;
		}
		
		private function HandleFadeComplete(event : SoundObjectEvent) : void
		{
			dispatchEvent(event);
			
			var soundItem : ISoundObject = event.soundItem;
			soundItem.removeEventListener(SoundObjectEvent.SOUND_OBJECT_FADE_COMPLETE, HandleFadeComplete);
		}
		
		private function HandleSoundPlayComplete(event : SoundObjectEvent):void
		{
			dispatchEvent(event);
		}


		override public function toString():String
		{
			return getQualifiedClassName(this);
		}

	}
}