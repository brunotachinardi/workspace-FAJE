package com.eguru.faje.mvcs.models.data {
	/**
	 * @author Bruno Tachinardi
	 */
	public class NumberVariableVO 
	{
		protected var _name : String;
		protected var _value : Number;
		protected var _max : Number;
		protected var _min : Number;
		
		public function NumberVariableVO(name : String) 
		{
			_name = name;
			_max = NaN;
			_min = NaN;
			_value = 0;
		}
		
		public function get value() : Number
		{
			return _value;
		}
		
		public function SetValue(v : Number) : Boolean
		{
			var newValue : Number = v > max ? max : (v < min ? min : v);
			if (newValue == _value) return false;
			_value = newValue;
			return true; 
		}
		
		public function get max() : Number
		{
			return isNaN(_max) ? Infinity : _max;
		}
		
		public function get min() : Number
		{
			return isNaN(_min) ? -Infinity : _min;
		}
		
		public function SetMaxMin(max : Number, min : Number) : void
		{
			if (max <= min) min = max-1;
			_max = max;
			_min = min;
		}
		
		public function get name() : String
		{
			return _name;
		}
	}
}
