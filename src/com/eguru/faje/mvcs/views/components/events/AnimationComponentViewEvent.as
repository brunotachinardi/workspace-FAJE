package com.eguru.faje.mvcs.views.components.events {
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class AnimationComponentViewEvent extends Event 
	{
		public static const ANIMATION_END : String = "AnimationComponentViewEvent.AnimationEnd";
		
		private var _eventName : String;
		
		public function AnimationComponentViewEvent(type : String, eventName : String) {
			super(type);
			_eventName = eventName;
		}
		
		public function get eventname() : String
		{
			return _eventName;
		}
	}
}
