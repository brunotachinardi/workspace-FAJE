package com.eguru.faje.mvcs.controllers.events {
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class RequestLoadAssetEvent extends Event 
	{
		public static const LOAD_ALL_ASSETS : String = "RequestLoadAssetEvent.LoadAllAssets";
		
		
		public function RequestLoadAssetEvent(type:String)
        {
            super(type);
        }

        override public function clone():Event
        {
            return new RequestLoadAssetEvent(type);
        }
	}
}
