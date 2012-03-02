package com.eguru.faje.mvcs.controllers.events {
	import flash.events.Event;
	/**
	 * @author Bruno Tachinardi
	 */
	public class DebugEvent extends Event
	{
		public static const ACTIVATE_CPU_STATS : String = "DebugEvent.ActivateCpuStats";
		public function DebugEvent(type : String)
        {
            super(type);
        }

        override public function clone() : Event
        {
            return new DebugEvent(type);
        }
	}
}
