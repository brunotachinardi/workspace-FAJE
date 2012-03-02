package com.eguru.faje.mvcs.models.data {
	/**
	 * @author Bruno Tachinardi
	 */
	public class TextSearchResultVO 
	{
		protected var _initialIndex : int;
		protected var _finalIndex : int;
		protected var _finalText : String;
		protected var _variableName : String;
		protected var _success : Boolean;
		
		public function TextSearchResultVO(argument : String, currentIndex :int, text : String, ProcessTextFunction : Function) 
		{
			var initialText : String = "[$" + argument + ":";
			_finalText = text;
			
			_initialIndex = _finalText.indexOf(initialText, currentIndex);
			if (_initialIndex == -1) return;
			_finalIndex = _finalText.indexOf("]", _initialIndex);
			if (_finalIndex == -1) return;
			
			_variableName = "";
			for (var i : int = _initialIndex + initialText.length; i < _finalIndex; i++) {
				_variableName += _finalText.charAt(i);
			}
			
			var textValue : String = ProcessTextFunction(_variableName); 
			_finalText = _finalText.replace(initialText + _variableName + "]", textValue);
			
			_success = true;
		}
		
		public function get success() : Boolean
		{
			return _success;
		}
		
		public function get finalText() : String
		{
			return _finalText;
		}
	}
}
