package com.eguru.faje.mvcs.models {
	import org.robotlegs.mvcs.Actor;
	import com.eguru.faje.mvcs.models.ITextPropertiesModel;
	import com.eguru.faje.mvcs.models.data.TextPropertiesVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TextPropertiesModel extends Actor implements ITextPropertiesModel 
	{
		protected var _textProperties : Vector.<TextPropertiesVO>;
		protected var _defaultProperties : TextPropertiesVO;
		
		public function TextPropertiesModel() 
		{
			_textProperties = new Vector.<TextPropertiesVO>();
		}

		public function AddTextProperty(textProperties : TextPropertiesVO) : TextPropertiesVO {
			if (ContainTextProperty(textProperties)) return textProperties;
			if (ContainTextPropertyByName(textProperties.name)) throw new Error("The Text Property name '" + textProperties.name + "' is already assigned to an existing text properties object. Please rename one of them as names should be unique.");
			_textProperties.push(textProperties);
			if (textProperties.name == "default") _defaultProperties = textProperties;
			return textProperties;
		}
		
		public function AddTextPropertyGroup(textPropertiesVector : Vector.<TextPropertiesVO>) : void 
		{
			for each (var textProperties : TextPropertiesVO in textPropertiesVector) 
			{
				AddTextProperty(textProperties);				
			}
		}

		public function RemoveTextProperty(textProperties : TextPropertiesVO) : TextPropertiesVO {
			if (!ContainTextProperty(textProperties)) return textProperties;
			_textProperties.splice(_textProperties.indexOf(textProperties), 1);
			return textProperties;
		}

		public function ContainTextProperty(textProperties : TextPropertiesVO) : Boolean {
			return _textProperties.indexOf(textProperties) != -1;
		}

		public function ContainTextPropertyByName(name : String) : Boolean {
			for each (var i : TextPropertiesVO in _textProperties) {
				if (i.name == name) return true;
			}
			return false;
		}

		public function GetTextPropertyByName(name : String) : TextPropertiesVO {
			for each (var i : TextPropertiesVO in _textProperties) {
				if (i.name == name) return new TextPropertiesVO(i.rawSpecifications);
			}
			if (_defaultProperties == null) throw new Error("The text properties named '" + name + "' was not found and no default value was set!");
			return new TextPropertiesVO(_defaultProperties.rawSpecifications);
		}

		public function AddRawTextPropertyGroup(texPropertiesArray : Array) : Vector.<TextPropertiesVO> 
		{
			var textProperties : Vector.<TextPropertiesVO> = new Vector.<TextPropertiesVO>();
			for each (var t : Object in texPropertiesArray) 
			{
				var textPropertiesVO : TextPropertiesVO = new TextPropertiesVO(t);
				textProperties.push(textPropertiesVO);
			}
			AddTextPropertyGroup(textProperties);
			return textProperties;
		}
	}
}
