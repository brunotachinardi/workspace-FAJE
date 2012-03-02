package com.eguru.faje.mvcs.services.factories {
	import flash.events.IEventDispatcher;
	import com.eguru.faje.mvcs.models.data.fsm.core.ICustomState;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IStateFactory 
	{
		function GenerateState(specifications : Object, dispatcher : IEventDispatcher) : ICustomState;
		function MapState(stateName : String, stateClass : Class) : void;
	}
}
