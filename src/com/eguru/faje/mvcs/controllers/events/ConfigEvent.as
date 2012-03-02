package com.eguru.faje.mvcs.controllers.events {
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ConfigEvent extends Event 
	{
		public static const PRELOADER_CONFIG_LOADED:String = "ConfigEvent.PRELOADER_CONFIG_LOADED";

        public function ConfigEvent(type:String)
        {
            super(type);
        }

        override public function clone():Event
        {
            return new ConfigEvent(type);
        }
	}
}
