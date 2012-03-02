package com.eguru.faje.mvcs.controllers.commands.custom {
	import flash.events.Event;
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.models.ITimerModel;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomCommand;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomRegisterTimerTickOpCommand extends CustomCommand {
		
		[Inject]
		public var timerModel : ITimerModel;
		
		[Inject]
		public var varModel : IAppNumberVariableModel;
		
		protected var _timerName : String;
		protected var _variableName : String;
		protected var _value : Number;
		
		override public function execute() : void
		{
			super.execute();
			
			_timerName = _spec["timer"];
			_variableName = _spec["variable"];
			_value = _spec["value"];
			if (!timerModel.TimerHasListener(_timerName)) timerModel.AddListener(_timerName, DoOperation);			
		}

		private function DoOperation(event : Event) : void 
		{
			varModel.AddToVariable(_variableName, _value);
		}
	}
}
