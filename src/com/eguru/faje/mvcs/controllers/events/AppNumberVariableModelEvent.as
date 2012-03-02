package com.eguru.faje.mvcs.controllers.events {
	import com.eguru.faje.mvcs.models.data.NumberVariableVO;
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class AppNumberVariableModelEvent extends Event 
	{
		public static const VARIABLE_CHANGED : String = "AppNumberVariableModelEvent.VariableChanged";
		
		protected var _variable : NumberVariableVO;

        public function AppNumberVariableModelEvent(type:String, variable : NumberVariableVO)
        {
            super(type);
			_variable = variable;
        }

        override public function clone():Event
        {
            return new AppNumberVariableModelEvent(type, _variable);
        }
		
		public function get name() : String
		{
			return _variable.name;
		}
		
		public function get value() : Number
		{
			return _variable.value;
		}
		
		public function get min() : Number
		{
			return _variable.min;
		}
		
		public function get max() : Number
		{
			return _variable.max;
		}
	}
}
