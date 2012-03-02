package com.eguru.faje.mvcs.models {
	/**
	 * @author Bruno Tachinardi
	 */
	public interface ITextsModel 
	{
		function AddTextFeed(feed : Object) : void;
		
		function GetVariableValue(name : String) : String;
		function SetVariable(name : String, value : String) : String;
		function SetVariableByFeed(name : String, feed : String) : String;
	}
}
