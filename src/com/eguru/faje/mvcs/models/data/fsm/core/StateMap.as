package com.eguru.faje.mvcs.models.data.fsm.core {
	/**
	 * @author Bruno Tachinardi
	 */
	public class StateMap 
	{
		private var _name : String;
		private var _stateClass : Class;
		
		public function StateMap(name : String, stateClass : Class) 
		{
			var stateClassTest : * = new stateClass(); 
			if (!(stateClassTest is ICustomState)) throw new Error("The State Class must implement ICustomState!");
			
			_name = name;
			_stateClass = stateClass;
		}
		
		public function get name() : String
		{
			return _name;
		}
		
		public function get stateClass() : Class
		{
			return _stateClass;
		}
	}
}
