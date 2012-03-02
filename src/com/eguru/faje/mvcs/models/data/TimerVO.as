package com.eguru.faje.mvcs.models.data {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * @author Bruno Tachinardi
	 */
	public class TimerVO 
	{
		private static const STOP : String = "STOP";
		private static const START : String = "START";
		
		protected var _name : String;
		protected var _status : String;
		protected var _timer : Timer;
		protected var _callbackList : Vector.<Function>;
		
		public function TimerVO(name : String, timer : Timer) : void
		{
			_name = name;
			_timer = timer;
			_status = STOP;
			_callbackList = new Vector.<Function>();
		}
		
		public function AddListener(callback : Function) : void
		{
			_callbackList.push(callback);
			_timer.addEventListener(TimerEvent.TIMER, callback);
		}
		
		public function RemoveListener(callback : Function) : void
		{
			_callbackList.splice(_callbackList.indexOf(callback), 1);
			_timer.removeEventListener(TimerEvent.TIMER, callback);
		}
		
		public function ClearListeners() : void
		{
			for each (var callback : Function in _callbackList) 
			{
				_timer.removeEventListener(TimerEvent.TIMER, callback);
			}
			_callbackList = new Vector.<Function>();
		}
		
		public function get name() :String
		{
			return _name;
		}
		
		public function get status() : String
		{
			return _status;
		}
		
		
		public function SetStatus(value : String) : void
		{
			if (_status == value) return;
			switch(value){
				case STOP:
					Stop();
					break;
				case START:
					Start();
					break;
				default:
			}
		}
		
		public function HasAnyListeners() : Boolean
		{
			return _callbackList.length > 0;
		}
		
		public function Start() : void
		{
			_timer.start();
			_status = START;
		}
		
		public function Stop() : void
		{
			_timer.stop();
			_status = STOP;
		}
		
		public function Reset() : void
		{
			_timer.reset();
		}
	}
}
