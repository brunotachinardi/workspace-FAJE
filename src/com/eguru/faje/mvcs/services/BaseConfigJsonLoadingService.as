package com.eguru.faje.mvcs.services {
	import com.adobe.serialization.json.JSON;
	import com.greensock.events.LoaderEvent;
	import org.robotlegs.mvcs.Actor;
	import com.greensock.loading.LoaderMax;
	/**
	 * @author Bruno Tachinardi
	 */
	public class BaseConfigJsonLoadingService extends Actor
	{
		
		protected var _loader : LoaderMax;
		private var _jsonName : String;

	    public function BaseConfigJsonLoadingService(jsonName : String) : void
	    {	
			_jsonName = jsonName;		
			_loader = new LoaderMax({name:"config_loader", onComplete:LoadCompleteHandler, onError:LoadErrorHandler});			
	    }
		
		protected function LoadCompleteHandler(event : LoaderEvent) : void 
		{
			var rawData : String = LoaderMax.getContent(_jsonName);
			var data : Object = JSON.decode(rawData);
			
			if (UpdateModel(data))
	        {
	            DispatchLoadCompleted();
	        }
	        else
	        {
	            DispatchLoadFailed();
	        }
		}
	
	
	    // abstract methods to be overridden
	    protected function UpdateModel(data : Object) : Boolean { data; return false; }
	
	    protected function LoadErrorHandler(event : LoaderEvent) : void { }
		
	    protected function DispatchLoadCompleted() : void { }

	    protected function DispatchLoadFailed() : void { }
	}
}
