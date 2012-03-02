package com.eguru.faje.mvcs.models {
	import com.eguru.faje.utils.sound.SoundObjectContainer;
	import org.robotlegs.mvcs.Actor;

	import com.eguru.faje.mvcs.models.ISoundModel;
	import com.greensock.TweenLite;
	import com.eguru.faje.utils.sound.core.ISoundObjectContainer;
	import com.eguru.faje.utils.sound.core.ISoundObject;

	import flash.media.Sound;
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class SoundModel extends Actor implements ISoundModel {
		
		public static const GLOBAL_SOUND_NAME : String = "global_sound_layer";
		public static const INTERFACE_FX_SOUND_NAME : String = "interface_fx_sound_layer";
		
		protected var _soundManager : ISoundObjectContainer;
		
		protected var _layers : Vector.<ISoundObjectContainer>;
		
		protected var _sounds : Vector.<ISoundObject>;
		
		public function SoundModel() 
		{
			_soundManager = new SoundObjectContainer(GLOBAL_SOUND_NAME);
			_layers = new Vector.<ISoundObjectContainer>();
			_sounds = new Vector.<ISoundObject>();
			_layers.push(_soundManager);
		}

		public function AddLibrarySound(linkageID : *, name : String) : ISoundObject 
		{
			var soundObject : ISoundObject = _soundManager.AddLibrarySound(linkageID, name);
			_sounds.push(soundObject);
			return soundObject;
		}

		public function AddExternalSound(path : String, name : String, buffer : Number = 1000, checkPolicyFile : Boolean = false) : ISoundObject 
		{
			var soundObject : ISoundObject = _soundManager.AddExternalSound(path, name, buffer, checkPolicyFile);
			_sounds.push(soundObject);
			return soundObject;
		}

		public function AddPreloadedSound(sound : Sound, name : String) : ISoundObject 
		{
			var soundObject : ISoundObject = _soundManager.AddPreloadedSound(sound, name);
			_sounds.push(soundObject);
			return soundObject;
		}

		public function AddSound(soundItem : ISoundObject) : ISoundObject 
		{
			var soundObject : ISoundObject = _soundManager.AddSound(soundItem);
			_sounds.push(soundObject);
			return soundObject;
		}
		
		public function ContainsSound(soundItem : ISoundObject) : Boolean 
		{
			for each (var sound : ISoundObject in _sounds) 
			{
				if (sound == soundItem) return true;
			}
			return false;
		}

		public function Contains(target : ISoundObject) : Boolean 
		{
			for each (var sound : ISoundObject in _sounds) 
			{
				if (sound == target) return true;
			}
			for each (var layer : ISoundObject in _layers) 
			{
				if (layer == target) return true;
			}
			return false;
		}

		public function GetSound(name : String) : ISoundObject 
		{
			for each (var sound : ISoundObject in _sounds) 
			{
				if (sound.name == name) return sound;
			}
			return null;
		}
		
		public function Get(name : String) : ISoundObject 
		{
			for each (var sound : ISoundObject in _sounds) 
			{
				if (sound.name == name) return sound;
			}
			
			for each (var layer : ISoundObject in _layers) 
			{
				if (layer.name == name) return layer;
			}
			return null;
		}

		public function RemoveSoundByName(name : String) : Boolean 
		{
			return RemoveSound(GetSound(name));
		}

		public function RemoveSound(soundItem : ISoundObject) : Boolean 
		{
			var index : int = _sounds.indexOf(soundItem);
			if (index == -1) return false;
			
			if (soundItem.parent != null) soundItem.parent.RemoveSound(soundItem);
			_sounds.splice(index, 1);
			return true;
		}

		public function RemoveAllSounds() : void 
		{
			for each (var soundItem : ISoundObject in _sounds) 
			{
				RemoveSound(soundItem);
			}
		}
		
		public function AddEmptyLayer(name : String) : ISoundObjectContainer 
		{
			return AddLayer(new SoundObjectContainer(name));
		}
		
		public function AddLayer(layer : ISoundObjectContainer) : ISoundObjectContainer 
		{
			var layerObject : ISoundObjectContainer = _soundManager.AddSound(layer) as ISoundObjectContainer;
			_layers.push(layerObject);
			return layerObject;
		}

		public function ContainsLayer(targetLayer : ISoundObjectContainer) : Boolean 
		{
			for each (var layer : ISoundObjectContainer in _layers) 
			{
				if (layer == targetLayer) return true;
			}
			return false;
		}

		public function GetLayer(name : String) : ISoundObjectContainer
		{
			for each (var layer : ISoundObjectContainer in _layers) 
			{
				if (layer.name == name) return layer;
			}
			return AddEmptyLayer(name);
		}

		public function RemoveLayerByName(name : String) : Boolean 
		{
			return RemoveLayer(GetLayer(name));
		}

		public function RemoveLayer(layer : ISoundObjectContainer) : Boolean 
		{
			var index : int = _layers.indexOf(layer);
			if (index == -1) return false;
			
			if (layer.parent != null) layer.parent.RemoveSound(layer);
			_layers.splice(index, 1);
			return true;
		}

		public function RemoveAllLayers() : void 
		{
			for each (var layer : ISoundObjectContainer in _layers) 
			{
				RemoveLayer(layer);
			}
		}

		public function PlaySound(name : String, volume : Number = 1, startTime : Number = 0, loops : int = 0, resumeTween : Boolean = true) : void 
		{
			Get(name).Play(volume, startTime, loops, resumeTween);
		}

		public function PauseSound(name : String, pauseTween : Boolean = true) : void 
		{
			Get(name).Pause(pauseTween);
		}

		public function StopSound(name : String) : void 
		{
			Get(name).Stop();
		}

		public function FadeSound(name : String, volume : Number = 0, fadeLength : Number = 1, stopOnComplete : Boolean = false) : void 
		{
			Get(name).Fade(volume, fadeLength, stopOnComplete);
		}

		public function MuteSound(name : String) : void 
		{
			Get(name).Mute();
		}

		public function UnmuteSound(name : String) : void 
		{
			Get(name).Unmute();
		}

		public function Play(startTime : Number = 0, loops : int = 0, volume : Number = 1, resumeTween : Boolean = true) : void 
		{
			_soundManager.Play(startTime, loops, volume, resumeTween);
		}

		public function Pause(pauseTween : Boolean = true) : void 
		{
			_soundManager.Pause(pauseTween);
		}

		public function Stop() : void 
		{
			_soundManager.Stop();
		}

		public function Fade(volume : Number = 0, fadeLength : Number = 1, stopOnComplete : Boolean = false) : void 
		{
			_soundManager.Fade(volume, fadeLength, stopOnComplete);
		}

		public function Mute() : void 
		{
			_soundManager.Mute();
		}

		public function Unmute() : void 
		{
			_soundManager.Unmute();
		}

		public function SetVolume(volume : Number) : void 
		{
			_soundManager.SetVolume(volume);
		}

		public function SetMuted(value : Boolean) : void 
		{
			_soundManager.SetMuted(value);
		}

		public function SetFadeTween(value : TweenLite) : void 
		{
			_soundManager.SetFadeTween(value);
		}

		public function Dispose() : void 
		{
			_soundManager.Dispose();
		}

		public function get name() : String 
		{
			return _soundManager.name;
		}

		public function get volume() : Number 
		{
			return _soundManager.volume;
		}

		public function get position() : int
		{
			return _soundManager.position;
		}

		public function get duration() : Number 
		{
			return _soundManager.duration;
		}

		public function get paused() : Boolean 
		{
			return _soundManager.paused;
		}

		public function get pausedByParent() : Boolean 
		{
			return false;
		}

		public function get parent() : ISoundObjectContainer 
		{
			return null;
		}

		public function get realVolume() : Number 
		{
			return _soundManager.realVolume;
		}

		public function set parent(value : ISoundObjectContainer) : void 
		{
			
		}
		
		public function dispatchEvent(event : Event) : Boolean 
		{
			return dispatch(event);
		}

		public function hasEventListener(type : String) : Boolean 
		{
			return _eventDispatcher.hasEventListener(type);
		}

		public function willTrigger(type : String) : Boolean 
		{
			return _eventDispatcher.willTrigger(type);
		}

		public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void 
		{
			_eventDispatcher.removeEventListener(type, listener, useCapture);
		}

		public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void 
		{
			_eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}

		public function AddSoundInLayer(sound : ISoundObject, layerName : String) : ISoundObject 
		{
			var layer : ISoundObjectContainer = GetLayer(layerName);
			if (layer.Contains(sound)) return sound;
			layer.AddSound(sound);
			return sound;
		}
	}
}
