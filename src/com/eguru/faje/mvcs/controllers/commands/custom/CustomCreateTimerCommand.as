package com.eguru.faje.mvcs.controllers.commands.custom {

	import com.eguru.faje.mvcs.models.ITimerModel;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomCreateTimerCommand extends CustomCommand 
	{
		[Inject]
		public var timerModel : ITimerModel;
		
		private const DEFAULT_AUTO_PLAY : Boolean = true;
		private const DEFAULT_DELAY : Number = 1000;
		private const DEFAULT_REPEAT : Number = 0;
		
		override public function execute() : void
		{
			super.execute();
			var timerName : String = _spec["name"];
			var autoPlay : Boolean = _spec.hasOwnProperty("autoPlay") ? _spec["autoPlay"] : DEFAULT_AUTO_PLAY;
			var delay : Number = _spec.hasOwnProperty("delay") ? _spec["delay"] : DEFAULT_DELAY;
			var repeat : Number = _spec.hasOwnProperty("repeat") ? _spec["repeat"] : DEFAULT_REPEAT;
			if (!timerModel.ContainsTimer(timerName)) {
				timerModel.AddTimer(timerName, autoPlay, delay, repeat);
			} else {
				timerModel.StartTimer(timerName);
			}

		}
	}
}
