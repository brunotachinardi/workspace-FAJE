package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.controllers.events.StateMachineEvent;
	
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IEventsReceptorModel 
	{
		function GetEventsList() : Vector.<StateMachineEvent>;
		function Clear() : void;
		function HasEventMessage(message : String) : Boolean;
		function StartListening() : void;
		function StopListening() :void;
	}
}
