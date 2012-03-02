package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.models.data.TextPropertiesVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface ITextPropertiesModel 
	{
		function AddTextProperty(textProperties : TextPropertiesVO) : TextPropertiesVO;
		function AddTextPropertyGroup(textPropertiesVector : Vector.<TextPropertiesVO>) : void;
		function AddRawTextPropertyGroup(textPropertiesArray : Array) : Vector.<TextPropertiesVO>;
		function RemoveTextProperty(textProperties : TextPropertiesVO) : TextPropertiesVO;
		function ContainTextProperty(textProperties : TextPropertiesVO) : Boolean;
		function ContainTextPropertyByName(name : String) : Boolean;
		function GetTextPropertyByName(name : String) : TextPropertiesVO;
	}
}
