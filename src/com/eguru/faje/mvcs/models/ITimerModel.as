package com.eguru.faje.mvcs.models {
	/**
	 * @author Bruno Tachinardi
	 */
	public interface ITimerModel 
	{
		function AddTimer(timerName : String, startOnCreation : Boolean = false, delay : Number = 50, repeatCount : Number = 0) : void;
		function RemoveTimer(timerName : String) : void;
		function StartTimer(timerName : String) : void;
		function PauseTimer(timerName : String) : void;
		function ResetTimer(timerName : String) : void;
		function AddListener(timerName : String, callback : Function) : void;
		function RemoveListener(timerName : String, callback : Function) : void;
		function ContainsTimer(timerName : String) : Boolean;
		function TimerHasListener(timerName : String) : Boolean;
	}
}
