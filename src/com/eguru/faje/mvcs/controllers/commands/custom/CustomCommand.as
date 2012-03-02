package com.eguru.faje.mvcs.controllers.commands.custom {
	import flash.events.Event;
	import com.eguru.faje.mvcs.controllers.events.CustomEvent;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomCommand extends Command {
		
		[Inject]
		public var event : Event;
		
		protected var _customEvent : CustomEvent;
		protected var _spec : Object;
		
		override public function execute() : void
		{
			_customEvent = event as CustomEvent;
			_spec = _customEvent.specifications;
		}
	}
}
