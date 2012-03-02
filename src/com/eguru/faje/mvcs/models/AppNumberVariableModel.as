package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.services.ISCORMService;
	import com.eguru.faje.mvcs.controllers.events.AppNumberVariableModelEvent;
	import com.eguru.faje.mvcs.models.data.NumberVariableVO;
	import org.robotlegs.mvcs.Actor;

	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;

	/**
	 * @author Bruno Tachinardi
	 */
	public class AppNumberVariableModel extends Actor implements IAppNumberVariableModel 
	{
		protected var _variables : Vector.<NumberVariableVO>;
		public static var instance : IAppNumberVariableModel;
		
		[Inject]
		public var scormService : ISCORMService;
		
		private var _varLoaded : Boolean;
		
		public function AppNumberVariableModel() 
		{
			_variables = new Vector.<NumberVariableVO>();
			instance = this;
		}
		
		public function GetVariableValue(name : String) : Number 
		{
			var value : Number = GetVariableByName(name).value;	
			_varLoaded = false;
			return value;
		}

		public function AddToVariable(name : String, value : Number) : Number 
		{
			var currentValue : Number = GetVariableValue(name);
			return SetVariable(name, currentValue + value);
		}

		public function SubtractFromVariable(name : String, value : Number) : Number 
		{
			var currentValue : Number = GetVariableValue(name);
			return SetVariable(name, currentValue - value);
		}

		public function SetVariable(name : String, value : Number) : Number 
		{
			var variable : NumberVariableVO = GetVariableByName(name);
			
			if (!_varLoaded && variable.SetValue(value))
			{
				var event : AppNumberVariableModelEvent = new AppNumberVariableModelEvent(AppNumberVariableModelEvent.VARIABLE_CHANGED, variable);
				dispatch(event);				
				scormService.SaveVariable(variable);
			}
			_varLoaded = false;
			return variable.value;
		}
		
		public function SetVariableProperties(name : String, value : Number, max : Number = 1, min : Number = 0) : NumberVariableVO 
		{
			var variable : NumberVariableVO = GetVariableByName(name);
			if (!_varLoaded) variable.SetValue(value);
			variable.SetMaxMin(max, min);
			var event : AppNumberVariableModelEvent = new AppNumberVariableModelEvent(AppNumberVariableModelEvent.VARIABLE_CHANGED, variable);
			dispatch(event);
			_varLoaded = false;
			return variable;
		}
		
		public function SetVariableMaxMin(name : String, max : Number = 1, min : Number = 0) : NumberVariableVO 
		{
			var variable : NumberVariableVO = GetVariableByName(name);
			_varLoaded = false;
			variable.SetMaxMin(max, min);
			
			var event : AppNumberVariableModelEvent = new AppNumberVariableModelEvent(AppNumberVariableModelEvent.VARIABLE_CHANGED, variable);
			dispatch(event);
			return variable;
		}
		
		private function GetVariableByName(name : String) : NumberVariableVO
		{
			for each (var v : NumberVariableVO in _variables) {
				if (v.name == name) return v;
			}
			var variable : NumberVariableVO = new NumberVariableVO(name);
			_variables.push(variable);
			_varLoaded = scormService.LoadVariable(variable);
			return variable;
		}

		public function GetVariableMax(name : String) : Number 
		{
			return GetVariableByName(name).max;
		}
		
		public function GetVariableMin(name : String) : Number 
		{
			return GetVariableByName(name).min;
		}
		
		public function CheckVariable(name : String, operation : String, value : Number) : Boolean
		{
			var variableValue : Number = GetVariableValue(name);
			switch(operation){
				case ">":
					return variableValue > value;
				case "<":
					return variableValue < value;
				case ">=":
					return variableValue >= value;
				case "<=":
					return variableValue <= value;
				case "==":
					return variableValue == value;
				case "!=":
					return variableValue != value;
			}
			return false;
		}
		
	}
}
