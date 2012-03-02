package com.eguru.faje.mvcs.models.data.fsm.transition {
	import com.eguru.faje.mvcs.models.EventsReceptorModel;
	import com.eguru.faje.fsm.transition.ITransitionChecker;

	/**
	 * @author Bruno Tachinardi
	 */
	public class EventTransitionChecker implements ITransitionChecker {
		
		protected var _message : String;
		
		public function EventTransitionChecker(message : String) 
		{
			_message = message;
		}
		
		public function Check() : Boolean 
		{
			return EventsReceptorModel.instance.HasEventMessage(_message);
		}
	}
}
