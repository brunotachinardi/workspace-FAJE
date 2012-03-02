package com.eguru.faje.mvcs.controllers.events {
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class FixedStateChangeEvent extends Event 
	{
		public static const PRELOADER_STATE : String = "FixedStateChangeEvent.PreloaderState";
		public static const GAME_CONFIG_STATE : String = "FixedStateChangeEvent.GameConfigState";

        public function FixedStateChangeEvent(type:String)
        {
            super(type);
        }

        override public function clone():Event
        {
            return new FixedStateChangeEvent(type);
        }
	}
}
