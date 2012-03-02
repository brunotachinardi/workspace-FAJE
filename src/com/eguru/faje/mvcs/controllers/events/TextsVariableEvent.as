package com.eguru.faje.mvcs.controllers.events {
	import com.eguru.faje.mvcs.models.data.TextVO;
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TextsVariableEvent extends Event 
	{
		
		public static const VARIABLE_CHANGED : String = "TextsVariableEvent.VariableChanged";
		
		protected var _variable : TextVO;

		public function TextsVariableEvent(type : String, variable : TextVO) 
		{
			super(type);
			_variable = variable;
		}
		
		override public function clone():Event
        {
            return new TextsVariableEvent(type, _variable);
        }
		
		public function get variable() : TextVO
		{
			return _variable;
		}
	}
}
