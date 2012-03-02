package com.eguru.faje.mvcs.models.data.fsm.core {
	import com.eguru.faje.mvcs.controllers.events.CustomEvent;
	import flash.events.IEventDispatcher;
	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomStateEventHandler 
	{
		protected var _enterEvents : Vector.<CustomEvent>;
		protected var _updateEvents : Vector.<CustomEvent>;
		protected var _exitEvents : Vector.<CustomEvent>;
		protected var _eventDispatcher : IEventDispatcher;

		public function CustomStateEventHandler(specification : Object, eventDispatcher : IEventDispatcher, state : ICustomState) 
		{
			_enterEvents = new Vector.<CustomEvent>();
			_updateEvents = new Vector.<CustomEvent>();
			_exitEvents = new Vector.<CustomEvent>();
			_eventDispatcher = eventDispatcher;
			
			if (specification.hasOwnProperty("events"))
			{
				var events : Object = specification["events"];
				var eventSpec : Object;
				if (events.hasOwnProperty("enter"))
				{
					for each (eventSpec in events["enter"]) 
					{
						_enterEvents.push(new CustomEvent(eventSpec["command"], state, eventSpec.hasOwnProperty("spec") ? eventSpec["spec"] : null));
					}
				}
				
				if (events.hasOwnProperty("update"))
				{
					for each (eventSpec in events["update"]) 
					{
						_updateEvents.push(new CustomEvent(eventSpec["command"], state, eventSpec.hasOwnProperty("spec") ? eventSpec["spec"]  : null));
					}
				}
				
				if (events.hasOwnProperty("exit"))
				{
					for each (eventSpec in events["exit"]) 
					{
						_exitEvents.push(new CustomEvent(eventSpec["command"], state, eventSpec.hasOwnProperty("spec") ? eventSpec["spec"]  : null));
					}
				}
			}
		}
		
		public function Enter() : void
		{
			DispatchEvents(_enterEvents);
		}
		
		public function Update() : void
		{
			DispatchEvents(_updateEvents);
		}
		
		public function Exit() : void
		{
			DispatchEvents(_exitEvents);
		}
		
		protected function DispatchEvents(events : Vector.<CustomEvent>) : void 
		{
			for each (var event : CustomEvent in events) 
			{
				Dispatch(event);
			}
		}

		protected function Dispatch(event : CustomEvent) : Boolean 
		{
			if(_eventDispatcher.hasEventListener(event.type))
 		        return _eventDispatcher.dispatchEvent(event);
 		 	return false;
		}
	}
}
