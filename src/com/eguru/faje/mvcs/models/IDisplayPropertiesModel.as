package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.models.data.DisplayPropertiesVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IDisplayPropertiesModel 
	{
		function AddDisplayProperty(dp : DisplayPropertiesVO) : DisplayPropertiesVO;
		function AddDisplayPropertyGroup(dps : Vector.<DisplayPropertiesVO>) : void;
		function AddRawDisplayPropertyGroup(displayPropertiesArray : Array) : Vector.<DisplayPropertiesVO>;
		function RemoveDisplayProperty(dp : DisplayPropertiesVO) : DisplayPropertiesVO;
		function ContainDisplayProperty(dp : DisplayPropertiesVO) : Boolean;
		function ContainDisplayPropertyByName(name : String) : Boolean;
		function GetDisplayPropertyByName(name : String) : DisplayPropertiesVO;
	}
}
