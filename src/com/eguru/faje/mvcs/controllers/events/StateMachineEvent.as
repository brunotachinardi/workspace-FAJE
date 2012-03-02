package com.eguru.faje.mvcs.controllers.events {
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class StateMachineEvent extends Event 
	{
		
		public static const MACHINE_EVENT : String = "StateMachineEvent.MachineEvent";
		
		public static const ASSETS_LOADED_MESSAGE : String = "AssetsLoadedMessage";
		public static const COMPONENTS_ACTIVATED_MESSAGE : String = "ComponentsActivatedMessage";
		public static const STATE_MACHINE_READY_MESSAGE : String = "StateMachineReadyMessage";
		public static const QUIZ_ANSWERED_MESSAGE : String = "QuizAnswered";
		
		protected var _message : String;
		
		public function StateMachineEvent(message : String)
        {
            super(MACHINE_EVENT);
			_message = message;
        }

        override public function clone():Event
        {
            return new StateMachineEvent(_message);
        }
		
		public function get message() :String
		{
			return _message;
		}
	}
}
