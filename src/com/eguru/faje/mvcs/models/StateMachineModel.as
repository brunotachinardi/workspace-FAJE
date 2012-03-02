package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.models.data.fsm.StateComponentSpecVO;
	import com.eguru.faje.mvcs.services.ISCORMService;
	import com.eguru.faje.mvcs.models.data.fsm.CustomOrthogonalState;
	import com.eguru.faje.mvcs.models.data.fsm.CustomComplexState;
	import com.eguru.faje.mvcs.models.data.fsm.ComponentState;
	import com.eguru.faje.mvcs.models.data.fsm.core.ICustomState;
	import com.eguru.faje.mvcs.services.factories.IStateFactory;
	import com.eguru.faje.mvcs.controllers.events.FixedStateChangeEvent;
	import com.eguru.faje.mvcs.models.data.fixed.FixedMachineStates;
	import flash.events.TimerEvent;
	import com.eguru.faje.fsm.core.IStateSystem;
	import com.eguru.faje.fsm.core.IState;
	import com.eguru.faje.fsm.transition.IStateTransition;

	import org.osflash.signals.ISignal;
	import org.robotlegs.mvcs.Actor;
	/**
	 * @author Bruno Tachinardi
	 */
	public class StateMachineModel extends Actor implements IStateMachineModel {
		
		protected var _stateMachineSystem : IStateSystem;
		
		[Inject]
		public var timerModel : ITimerModel;
		
		[Inject]
		public var eventsReceptor : IEventsReceptorModel;
		
		[Inject]
		public var stateFactory : IStateFactory;
		
		[Inject]
		public var componentsModel : IComponentModel;
		
		[Inject]
		public var scormService : ISCORMService;
		
		[Inject]
		public var variablesModel : IAppNumberVariableModel;
		
		protected var _cleared : Boolean;
		
		private var _loaded : Boolean;
		private var _exitingComponents : Vector.<StateComponentSpecVO>;
		
		[Inject]
		public function StateMachineModel(stateMachine : IStateSystem) 
		{
			_stateMachineSystem = stateMachine;
			_exitingComponents = new Vector.<StateComponentSpecVO>;
		}
		
		public function Start() : void
		{
			timerModel.AddTimer("MainLoop", true, 150);
			timerModel.AddListener("MainLoop", UpdateMachine);
			eventsReceptor.StartListening();
			_stateMachineSystem.transitioned.add(CheckStateTransitions);
			_stateMachineSystem.stateExiting.add(StateExit);
			_stateMachineSystem.stateEntering.add(StateEnter);
		}
		
		
		protected function UpdateMachine(event : TimerEvent) : void
		{
			_cleared = false;
			_stateMachineSystem.Update();
			if (!_cleared) {
				eventsReceptor.Clear();		
				_cleared = true;	
			}
		}
		
		private function StateExit(state : IState) : void 
		{
			trace("Exiting state: " + state.type);
			if (state is CustomComplexState)
			{
				var complexState : CustomComplexState = state as CustomComplexState;
				complexState.stateExiting.remove(StateExit);
				complexState.stateEntering.remove(StateEnter);
			}
			if (state is ComponentState)
			{
				_exitingComponents = ComponentState(state).components;
			}
		}
		
		private function StateEnter(state : IState) : void 
		{
			trace("Entering state: " + state.type);			
			//States logic
			if (state is ComponentState)
			{				
				var componentState : ComponentState = state as ComponentState;
				componentsModel.ActivateComponentsByStateSpec(componentState.components, _exitingComponents);
				_exitingComponents = new Vector.<StateComponentSpecVO>;
				if (_loaded && state.parent is CustomComplexState && CustomComplexState(state.parent).saveScormOnStateChange) scormService.SaveStates(_stateMachineSystem);
			} 
			else if (state is CustomComplexState)
			{
				var complexState : CustomComplexState = state as CustomComplexState;
				complexState.stateExiting.add(StateExit);
				complexState.stateEntering.add(StateEnter);
				StateEnter(complexState.currentState);
			} 
			else if (state is CustomOrthogonalState)
			{
				var orthogonalState : CustomOrthogonalState = state as CustomOrthogonalState;
				for each (var subState : IState in orthogonalState.states) 
				{
					StateEnter(subState);
				}
			}
			
			if (state.type == FixedMachineStates.MAIN && !_loaded)
			{
				scormService.LoadStates(_stateMachineSystem);
				_loaded = true;
				return;
			}
		}
		
		protected function CheckStateTransitions(machine : IStateSystem) : void
		{
			if (!_cleared) {
				eventsReceptor.Clear();		
				_cleared = true;	
			}
			
			trace("Transition occured: from [State: "  + machine.lastState.type + "] to [State: " + machine.currentState.type + "]");
			
			//Fixed game logic
			if (machine.currentState.type == FixedMachineStates.PRELOADER)
			{
				dispatch(new FixedStateChangeEvent(FixedStateChangeEvent.PRELOADER_STATE));
			} else if (machine.currentState.type == FixedMachineStates.GAME_CONFIG)
			{
				dispatch(new FixedStateChangeEvent(FixedStateChangeEvent.GAME_CONFIG_STATE));
			}			
		}
		
		public function get currentState() : IState {
			return _stateMachineSystem.currentState;
		}

		public function get currentTransition() : IStateTransition {
			return _stateMachineSystem.currentTransition;
		}

		public function get defaultState() : IState {
			return _stateMachineSystem.defaultState;
		}

		public function SetDefaultState(state : IState) : IState {
			return _stateMachineSystem.SetDefaultState(state);
		}

		public function CancelTransition() : Boolean {
			return _stateMachineSystem.CancelTransition();
		}

		public function ResetToDefault() : IState {
			return _stateMachineSystem.ResetToDefault();
		}

		public function get toBeTransitioned() : ISignal {
			return _stateMachineSystem.toBeTransitioned;
		}

		public function AddState(state : IState) : IState {
			return _stateMachineSystem.AddState(state);
		}

		public function RemoveState(state : IState) : IState {
			return _stateMachineSystem.RemoveState(state);
		}

		public function ContainState(state : IState) : Boolean {
			return _stateMachineSystem.ContainState(state);
		}

		public function get transitioned() : ISignal {
			return _stateMachineSystem.transitioned;
		}

		public function AddRawStatesGroup(statesArray : Array) : Vector.<ICustomState> 
		{
			var states : Vector.<ICustomState> = new Vector.<ICustomState>();
			for each (var stateObject : Object in statesArray) 
			{
				var newState : ICustomState = stateFactory.GenerateState(stateObject, _eventDispatcher);
				states.push(newState);
				AddState(newState);
			}			
			return states;
		}
	}
}
