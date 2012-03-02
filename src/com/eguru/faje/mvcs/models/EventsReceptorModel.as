package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.controllers.events.StateMachineEvent;
	import org.robotlegs.mvcs.Actor;

	import com.eguru.faje.mvcs.models.IEventsReceptorModel;

	/**
	 * @author Bruno Tachinardi
	 */
	public class EventsReceptorModel extends Actor implements IEventsReceptorModel 
	{
		public static var instance : EventsReceptorModel;
		
		protected var _registeredEvents : Vector.<StateMachineEvent>;		
		
		public function EventsReceptorModel() 
		{
			_registeredEvents = new Vector.<StateMachineEvent>();	
			instance = this;		
		}
		
		public function StartListening() : void
		{
			_eventDispatcher.addEventListener(StateMachineEvent.MACHINE_EVENT, RegisterEvent);
		}
		
		public function StopListening() :void
		{
			_eventDispatcher.removeEventListener(StateMachineEvent.MACHINE_EVENT, RegisterEvent);
		}
		
		protected function RegisterEvent(event : StateMachineEvent) : void
		{
			_registeredEvents.push(event);
		}
		
		public function GetEventsList() : Vector.<StateMachineEvent> 
		{
			return _registeredEvents;
		}

		public function Clear() : void 
		{
			_registeredEvents = new Vector.<StateMachineEvent>();
		}

		public function HasEventMessage(message : String) : Boolean {
			for each (var event : StateMachineEvent in _registeredEvents) {
				if (event.message == message) {
					return true;
				}
			}
			return false;
		}
	}
}
