package com.eguru.faje.mvcs.models.data.fsm.transition {
	import com.eguru.faje.fsm.transition.StateTransition;

	/**
	 * @author Bruno Tachinardi
	 */
	public class EventStateTransition extends StateTransition 
	{
		public function EventStateTransition(parentId : String, targetId : String, message : String, priority : int = 0, cancellable : Boolean = true) 
		{
			super(parentId, targetId, priority, cancellable);
			AddChecker(new EventTransitionChecker(message));
		}
	}
}
