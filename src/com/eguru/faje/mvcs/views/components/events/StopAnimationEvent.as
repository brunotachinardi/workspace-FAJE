package com.eguru.faje.mvcs.views.components.events {
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class StopAnimationEvent extends Event {
		
		public static const STOP_ANIMATION : String = "StopAnimationEvent.StopAnimation";
		
		private var _animationName : String;
		
		public function StopAnimationEvent(type : String, animationName : String) {
			super(type);
			_animationName = animationName;
		}
		
		public function get animationName() : String
		{
			return _animationName;
		}
	}
}
