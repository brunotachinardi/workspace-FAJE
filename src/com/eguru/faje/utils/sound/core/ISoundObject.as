package com.eguru.faje.utils.sound.core {
	import flash.events.IEventDispatcher;
	import com.greensock.TweenLite;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface ISoundObject extends IEventDispatcher
	{
		function Play(startTime : Number = 0, loops : int = 0, volume : Number = 1, resumeTween : Boolean = true) : void;
		function Pause(pauseTween : Boolean = true) : void;
		function Stop() : void;
		function Fade(volume : Number = 0, fadeLength : Number = 1, stopOnComplete : Boolean = false) : void;
		function Mute() : void;
		function Unmute() : void;
		function SetVolume(volume : Number) : void;
		function SetMuted(value : Boolean) : void;
		function SetFadeTween(value : TweenLite) : void;
		function Dispose() : void;
		
		function get name() : String;
		function get volume() : Number;
		function get position() : int;
		function get duration() : Number;
		function get paused() : Boolean;
		function get pausedByParent() : Boolean;
		function get parent() : ISoundObjectContainer;
		function set parent(value : ISoundObjectContainer) : void;
		function get realVolume() : Number;
		
	}
}
