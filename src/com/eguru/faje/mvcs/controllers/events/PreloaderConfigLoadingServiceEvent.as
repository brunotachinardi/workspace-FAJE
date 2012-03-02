package com.eguru.faje.mvcs.controllers.events {
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class PreloaderConfigLoadingServiceEvent extends Event 
	{
		
		public static const LOAD_REQUESTED:String = "PreloaderConfigLoadingServiceEvent.loadRequested";
        public static const LOAD_COMPLETED:String = "PreloaderConfigLoadingServiceEvent.loadCompleted";
        public static const LOAD_FAILED:String = "PreloaderConfigLoadingServiceEvent.loadFailed";
        public static const INVALID_DATA:String = "PreloaderConfigLoadingServiceEvent.invalidData";
		
		public function PreloaderConfigLoadingServiceEvent(type:String)
        {
            super(type);
        }

        override public function clone():Event
        {
            return new PreloaderConfigLoadingServiceEvent(type);
        }
	}
}
