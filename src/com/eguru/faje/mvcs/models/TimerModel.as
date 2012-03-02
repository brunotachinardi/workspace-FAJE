package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.services.ISCORMService;
	import flash.utils.Timer;
	import com.eguru.faje.mvcs.models.data.TimerVO;
	import com.eguru.faje.mvcs.models.ITimerModel;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TimerModel implements ITimerModel 
	{
		
		protected var _timers : Vector.<TimerVO>;
		
		[Inject]
		public var scormService : ISCORMService;
		
		public function TimerModel() 
		{
			_timers = new Vector.<TimerVO>();
		}		
		
		public function AddTimer(timerName : String, startOnCreation : Boolean = false, delay : Number = 50, repeatCount : Number = 0) : void 
		{
			if (ContainsTimer(timerName)) 
			{
				throw new Error("There already is a timer named '" + timerName + "'!");
			}
			
			var newTimer : Timer = new Timer(delay, repeatCount);
			var newTimerVO : TimerVO = new TimerVO(timerName, newTimer);
			_timers.push(newTimerVO);
			
			if (startOnCreation)
			{
				newTimerVO.Start();
			}
			scormService.LoadTimer(newTimerVO);
		}

		public function RemoveTimer(timerName : String) : void 
		{
			for each (var timer : TimerVO in _timers) 
			{
				if (timer.name == timerName) 
				{
					_timers.splice(_timers.indexOf(timer), 1);
					timer.ClearListeners();
				}
			}
		}

		public function StartTimer(timerName : String) : void 
		{
			var timer : TimerVO = GetTimerByName(timerName);
			timer.Start();
			scormService.SaveTimer(timer);
		}

		public function PauseTimer(timerName : String) : void 
		{
			var timer : TimerVO = GetTimerByName(timerName);
			timer.Stop();
			scormService.SaveTimer(timer);
		}

		public function ResetTimer(timerName : String) : void 
		{
			var timer : TimerVO = GetTimerByName(timerName);
			timer.Reset();
		}

		public function AddListener(timerName : String, callback : Function) : void 
		{
			GetTimerVOByName(timerName).AddListener(callback);
		}
		
		public function RemoveListener(timerName : String, callback : Function) : void 
		{
			GetTimerVOByName(timerName).RemoveListener(callback);
		}
		
		public function ContainsTimer(timerName : String) : Boolean {
			return GetTimerByName(timerName) != null;
		}
		
		private function GetTimerByName(name : String) : TimerVO
		{
			for each (var timer : TimerVO in _timers) {
				if (timer.name == name) return timer;
			}
			return null;
		}
		
		private function GetTimerVOByName(name : String) : TimerVO
		{
			for each (var timer : TimerVO in _timers) {
				if (timer.name == name) return timer;
			}
			return null;
		}

		public function TimerHasListener(timerName : String) : Boolean {
			return GetTimerVOByName(timerName).HasAnyListeners();
		}
	}
}
