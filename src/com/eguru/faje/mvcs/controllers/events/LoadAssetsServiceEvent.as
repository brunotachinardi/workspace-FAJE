package com.eguru.faje.mvcs.controllers.events {
	import flash.events.Event;
	/**
	 * @author Bruno Tachinardi
	 */
	public class LoadAssetsServiceEvent extends Event
	{
        public static const LOAD_COMPLETED:String = "LoadAssetsServiceEvent.loadCompleted";
        public static const LOAD_FAILED:String = "LoadAssetsServiceEvent.loadFailed";
		public static const LOAD_PROGRESS:String = "LoadAssetsServiceEvent.loadProgress";
		
		
		public function LoadAssetsServiceEvent(type:String)
        {
            super(type);
        }

        override public function clone():Event
        {
            return new PreloaderConfigLoadingServiceEvent(type);
        }
	}
}
