package com.eguru.faje.mvcs.models.data {
	/**
	 * @author Bruno Tachinardi
	 */
	public class TextVO 
	{
		protected var _name : String;
		protected var _value : String;
		
		public function TextVO(name : String) {
			_name = name;
			_value = "";
		}
		
		public function get value() : String
		{
			return _value;
		}
		
		public function SetValue(value : String) : Boolean
		{
			if (_value == value) return false;
			_value = value;
			return true;
		}
		
		public function get name() : String
		{
			return _name;
		}
	}
}
