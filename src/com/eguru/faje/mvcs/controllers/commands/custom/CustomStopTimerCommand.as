package com.eguru.faje.mvcs.controllers.commands.custom {
	import com.eguru.faje.mvcs.models.ITimerModel;
	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomStopTimerCommand extends CustomCommand
	{
		[Inject]
		public var timerModel : ITimerModel;
		
		override public function execute() : void
		{
			super.execute();
			var timerName : String = _spec["name"];
			if (timerModel.ContainsTimer(timerName)) timerModel.PauseTimer(timerName);
			else trace("Could not find timer " + timerName + " in the Stop Command");
		}
	}
}
