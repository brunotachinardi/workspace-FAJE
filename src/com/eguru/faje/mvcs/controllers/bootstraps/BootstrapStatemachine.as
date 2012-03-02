package com.eguru.faje.mvcs.controllers.bootstraps {
	import com.eguru.faje.mvcs.controllers.events.StateMachineEvent;
	import com.eguru.faje.mvcs.models.data.fixed.FixedMachineStates;
	import com.eguru.faje.mvcs.models.data.fsm.SingleEventState;
	import com.eguru.faje.fsm.core.IState;
	import com.eguru.faje.mvcs.models.IStateMachineModel;
	/**
	 * @author Bruno Tachinardi
	 */
	public class BootstrapStatemachine extends Object
	{
		
		public function BootstrapStatemachine(stateMachine : IStateMachineModel)  : void
		{
			var preloaderLoadState : IState = new SingleEventState(FixedMachineStates.PRELOADER_LOADING, FixedMachineStates.PRELOADER, StateMachineEvent.COMPONENTS_ACTIVATED_MESSAGE);
			stateMachine.AddState(preloaderLoadState);
			stateMachine.SetDefaultState(preloaderLoadState);
			
			var preloaderState : IState = new SingleEventState(FixedMachineStates.PRELOADER, FixedMachineStates.GAME_CONFIG, StateMachineEvent.ASSETS_LOADED_MESSAGE);
			stateMachine.AddState(preloaderState);
			
			var gameConfigState : IState = new SingleEventState(FixedMachineStates.GAME_CONFIG, FixedMachineStates.MAIN, StateMachineEvent.STATE_MACHINE_READY_MESSAGE);
			stateMachine.AddState(gameConfigState);
			
			stateMachine.Start();
		}
	}
}