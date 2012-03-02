package com.eguru.faje.mvcs.controllers.bootstraps {
	import com.eguru.faje.mvcs.models.data.fsm.CustomComplexState;
	import com.eguru.faje.mvcs.models.data.fsm.CustomOrthogonalState;
	import com.eguru.faje.mvcs.models.data.fsm.CustomState;
	import com.eguru.faje.mvcs.models.data.fsm.ComponentState;
	import com.eguru.faje.mvcs.services.factories.IStateFactory;
	/**
	 * @author Bruno Tachinardi
	 */
	public class BootstrapStates extends Object 
	{
		public function BootstrapStates(stateFactory : IStateFactory) 
		{
			stateFactory.MapState("ComponentState", ComponentState);
			stateFactory.MapState("State", CustomState);
			stateFactory.MapState("OrthogonalState", CustomOrthogonalState);
			stateFactory.MapState("ComplexState", CustomComplexState);
		}
	}
}
