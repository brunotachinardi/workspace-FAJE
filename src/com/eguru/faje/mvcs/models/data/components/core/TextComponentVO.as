package com.eguru.faje.mvcs.models.data.components.core {
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.models.data.TextSearchResultVO;
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.eguru.faje.mvcs.models.data.TextPropertiesVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TextComponentVO extends ComponentVO
	{
		protected var _textProperties : TextPropertiesVO;
		protected var _text : String;
		private var _textModel : ITextsModel;
		private var _numberModel : IAppNumberVariableModel;
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) : void {
			
			super.Initialize(specifications, models);
			_textModel = models.textModel;
			_numberModel = models.varsModel;
			_textProperties = models.textPropertiesModel.GetTextPropertyByName(specifications["textProperties"] as String);
			
			if (specifications.hasOwnProperty("text"))
				_text = specifications["text"] as String;			
		}
		
		public virtual function GetText(args : Object = null) : String
		{
			var finalText : String;
			if (args != null && args.hasOwnProperty("text")) finalText = args["text"];
			else finalText = _text;
			return ProcessText(finalText);
		}

		private function ProcessText(text : String) : String
		{
			var currentIndex : int;
			var textSearchResult : TextSearchResultVO;
			var finalText : String = text;
			
			//Process 'var' arguments 
			currentIndex = 0;
			while (true)
			{
				textSearchResult = new TextSearchResultVO("var", currentIndex, finalText, GetTextVarValue);
				if (!textSearchResult.success) break;
				finalText = textSearchResult.finalText;
			}
			
			//Process 'num' arguments 
			currentIndex = 0;
			while (true)
			{
				textSearchResult = new TextSearchResultVO("num", currentIndex, finalText, GetNumberVarValue);
				if (!textSearchResult.success) break;
				finalText = textSearchResult.finalText;
			}
			
			return finalText;
		}
		
		private function GetTextVarValue(varName : String) : String
		{
			return _textModel.GetVariableValue(varName)
		}
		
		private function GetNumberVarValue(varName : String) : String
		{
			return _numberModel.GetVariableValue(varName) + "";
		}
		
		public function get textProperties() : TextPropertiesVO 
		{
			return _textProperties;
		}
		
		public function get text() : String 
		{
			return _text;
		}
		
		public function get html() : Boolean 
		{
			if (_textProperties == null) return false;
			return _textProperties.html;
		}
	}
}
