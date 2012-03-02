package com.eguru.faje.mvcs.models.data.fsm {
	import com.eguru.faje.mvcs.models.data.fsm.transition.EventStateTransition;
	import com.eguru.faje.fsm.core.State;

	/**
	 * @author Bruno Tachinardi
	 */
	public class SingleEventState extends State 
	{		
		public function SingleEventState(type : String, targetId : String, event : String) {
			super(type);
			AddTransition(new EventStateTransition(type, targetId, event));
		}
	}
}
