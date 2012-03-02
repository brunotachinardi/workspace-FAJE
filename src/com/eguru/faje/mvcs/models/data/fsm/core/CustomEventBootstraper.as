package com.eguru.faje.mvcs.models.data.fsm.core {
	import flash.events.IEventDispatcher;
	import com.eguru.faje.mvcs.models.data.fsm.transition.EventTransitionChecker;
	import com.eguru.faje.mvcs.models.data.fsm.transition.VariableTransitionChecker;
	import com.eguru.faje.fsm.transition.StateTransition;
	import com.eguru.faje.fsm.transition.IStateTransition;
	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomEventBootstraper 
	{
		public function Initialize(specification : Object, eventDispatcher : IEventDispatcher, state : ICustomState) : CustomStateEventHandler
		{
			for each (var transitionObj : Object in specification["transitions"]) 
			{
				var transition : IStateTransition = new StateTransition(state.type, transitionObj["to"]);
				
				if (transitionObj.hasOwnProperty("event"))
					transition.AddChecker(new EventTransitionChecker(transitionObj["event"]));
					
				if (transitionObj.hasOwnProperty("variable"))
					transition.AddChecker(new VariableTransitionChecker(transitionObj["variable"]));
					
				state.AddTransition(transition);
				
			}	
			return new CustomStateEventHandler(specification, eventDispatcher, state);
		}
	}
}
