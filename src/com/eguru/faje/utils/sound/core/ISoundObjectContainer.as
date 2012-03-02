package com.eguru.faje.utils.sound.core {
	import flash.media.Sound;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface ISoundObjectContainer extends ISoundObject
	{
		//Add Sound functions
		function AddLibrarySound(linkageID : *, name : String) : ISoundObject;
		function AddExternalSound(path : String, name : String, buffer : Number = 1000, checkPolicyFile : Boolean = false) : ISoundObject;
		function AddPreloadedSound(sound : Sound, name : String) : ISoundObject;
		function AddSound(soundItem : ISoundObject) : ISoundObject;
		function Contains(soundItem : ISoundObject) : Boolean;
		function GetSound(name : String) : ISoundObject;
		function RemoveSoundByName(name : String) : Boolean;
		function RemoveSound(soundItem : ISoundObject) : Boolean;
		function RemoveAllSounds():void;
		function PlaySound(name : String, volume : Number = 1, startTime : Number = 0, loops : int = 0, resumeTween : Boolean = true) : void;
		function PauseSound(name : String, pauseTween : Boolean = true) : void;
		function StopSound(name : String) : void;
		function FadeSound(name : String, volume : Number = 0, fadeLength : Number = 1, stopOnComplete : Boolean = false) : void;
		function MuteSound(name : String) : void;
		function UnmuteSound(name : String) : void;
	}
}
