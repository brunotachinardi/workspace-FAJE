package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.models.data.NumberVariableVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IAppNumberVariableModel
	{
		function GetVariableValue(name : String) : Number;
		function GetVariableMax(name : String) : Number;
		function GetVariableMin(name : String) : Number;
		function AddToVariable(name : String, value : Number) : Number;
		function SubtractFromVariable(name : String, value : Number) : Number;
		function SetVariable(name : String, value : Number) : Number;
		function SetVariableMaxMin(name : String, max : Number = 1, min : Number = 0) : NumberVariableVO;
		function SetVariableProperties(name : String, value : Number, max : Number = 1, min : Number = 0) : NumberVariableVO;
		function CheckVariable(name : String, operation : String, value : Number) : Boolean;
	}
}
