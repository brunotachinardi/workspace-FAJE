package com.eguru.faje.mvcs.models.data.fsm.transition {
	import com.eguru.faje.mvcs.models.AppNumberVariableModel;
	import com.eguru.faje.fsm.transition.ITransitionChecker;

	/**
	 * @author Bruno Tachinardi
	 */
	public class VariableTransitionChecker implements ITransitionChecker 
	{
		protected var _name : String;
		protected var _operation : String;
		protected var _value : Number;
		
		public function VariableTransitionChecker(spec : Object) 
		{
			_name = spec["name"];
			_operation = spec["operation"];
			_value = spec["value"];
		}
		
		public function Check() : Boolean 
		{
			return AppNumberVariableModel.instance.CheckVariable(_name, _operation, _value);
		}
	}
}
