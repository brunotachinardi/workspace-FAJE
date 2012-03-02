package com.eguru.faje.mvcs.models.data.components {
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.eguru.faje.mvcs.models.data.components.core.TextComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TextBoxComponentVO extends TextComponentVO 
	{
		
		protected var _backgroundImageName : String;
		protected var _variableName : String;
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) : void
		{
			super.Initialize(specifications, models);
			
			_backgroundImageName = "";
			_variableName = "";
			
			if (specifications.hasOwnProperty("image"))
			{
				_backgroundImageName = specifications["image"] as String;
				assetsNames.push(_backgroundImageName);
			}
			
			if (specifications.hasOwnProperty("variable"))
			{
				_variableName = specifications["variable"] as String;
			}
		}
		
		public function get variableName() : String
		{
			return _variableName;
		}
		
		public function get backgroundImagename() : String
		{
			return _backgroundImageName;
		}
		
		override public function GetText(args : Object = null) : String
		{
			if (args == null) throw new Error("Must pass an args object containing a text property");
			if (!args.hasOwnProperty("text")) throw new Error("Must pass a text property in the args variable");
			
			var finalText : String;
			
			if (args["text"] == "") finalText = _text;
			else finalText = args["text"];
			
			return super.GetText({text : finalText});
		}
	}
}
