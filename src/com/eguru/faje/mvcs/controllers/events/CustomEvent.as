package com.eguru.faje.mvcs.controllers.events {
	import com.eguru.faje.mvcs.models.data.fsm.core.ICustomState;
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomEvent extends Event 
	{
		
		public static const CREATE_TIMER : String = "CreateTimer";
		public static const REGISTER_TIMER_TICK_OP : String = "RegisterTimerTickOp";
		public static const SET_TEXT : String = "SetText";
		public static const SET_TEXT_BY_FEED : String = "SetTextByFeed";
		public static const SET_QUIZ_BY_RANDOM_FEED : String = "SetQuizByRandomFeed";
		public static const STOP_TIMER : String = "StopTimer";
		public static const START_TIMER : String = "PlayTimer";
		public static const SET_VARIABLE : String = "SetVariable";
		public static const RESET_QUIZ : String = "ResetQuiz";
		public static const SET_VARIABLE_TO_MAX : String = "SetVariableToMax";
		public static const SET_FAILED : String = "SetFailed";
		public static const SET_COMPLETED : String = "SetCompleted";
		
		
		protected var _specifications : Object;
		protected var _state : ICustomState;
		
		public function CustomEvent(type : String, state : ICustomState, specs : Object)
        {
            super(type);
			_specifications = specs;
			_state = state;
        }

        override public function clone():Event
        {
            return new CustomEvent(type, _state, _specifications);
        }
		
		public function get specifications() :Object
		{
			return _specifications;
		}
		
		public function get state() :Object
		{
			return _state;
		}
	}
}
