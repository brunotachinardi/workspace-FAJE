package com.eguru.faje.fsm.core {
	import com.eguru.faje.fsm.transition.IStateTransition;
	import org.osflash.signals.Signal;
	import org.osflash.signals.ISignal;

	/**
	 * The basic state machine for a FSM architecture
	 *
	 *@author Bruno Tachinardi
	 *@langversion Actionscript 3
	 */
	public class ComplexState extends StateContainer implements IStateSystem
	{
		
		/**
		 * The current active state
		 */
		protected var _currentState : IState;
		
		protected var _lastState : IState;
		
		/**
		 * The default state (whenever the machine encounters itself without a currentState, it will activate this state)
		 */
		protected var _defaultState : IState;
		
		private var _cancelTransition : Boolean;
		
		protected var _currentTransition : IStateTransition;
		
		protected var _toBeTransitioned : ISignal;
		
		protected var _stateEntering : ISignal;
		
		protected var _stateExiting : ISignal;
		
		protected var _transitioned : ISignal;
		
		
		/**
		 * The constructor of the class
		 * 
		 * @param type The type of the machine
		 */
		public function ComplexState (type : String) : void 
		{
			super(type);
			_subStates = new Vector.<IState>();
			_toBeTransitioned = new Signal(IStateSystem);
			_transitioned = new Signal(IStateSystem);
			_stateEntering = new Signal(IState);
			_stateExiting = new Signal(IState);
		}
		
		public override function Enter() : void 
		{
			if (_currentState != null) _currentState.Enter();
			super.Enter();
		}
		
		public override function Exit() : void 
		{
			if (_currentState != null) _currentState.Exit();
			super.Exit();
		}
		
		/**
		 * The function the system holding the machine must call in its main loop to keep the machine activated.
		 */
		public override function Update() : void 
		{
			_cancelTransition = false;
			if (_subStates.length == 0) {
				return;
			}
			
			if (_currentState == null) {
				_currentState = _defaultState;
				if (_currentState == null) {
					return;
				} else {
					_stateEntering.dispatch(_currentState);
					_currentState.Enter();
				}
			}
				
			_currentTransition = _currentState.CheckTransitions();		
			
			if (_currentTransition != null) {
				var goalId : String = _currentTransition.targetId;
				if (TransitionState()) {
					TransitionToState(goalId);
				}				
				_currentTransition = null;
			}
			
			currentState.Update();
			super.Update();
		}

		public function TransitionToState(stateId : String) : void 
		{
			if (_currentState == null) return;
			_stateExiting.dispatch(_currentState);
			_currentState.Exit();
			_lastState = _currentState;
			_currentState = GetStateByType(stateId);
			if (_currentState == null) throw new Error("Failed to transition to state [State: " + stateId + "], a state with this ID could not be found in this machine.");
			_stateEntering.dispatch(_currentState);
			_currentState.Enter();
			_transitioned.dispatch(this);
		}
		
		override public function AddState(state : IState) : IState
		{
			super.AddState(state);
			if (_defaultState == null) _defaultState = state;
			return state;			
		}
		
		override public function RemoveState(state : IState) : IState
		{
			super.RemoveState(state);
			if (_defaultState == state) 
			{
				_defaultState = _subStates.length > 0 ? _subStates[0] : null;
			}
			
			if (_currentState == state)
			{
				_currentState = null;
			}
			return state;
		}
		
		/**
		 * This function is used to allow listeners to the toBeTransitioned signal
		 * to be able to call CancelTransition to stop the current transition
		 */
		private function TransitionState() : Boolean {
			_toBeTransitioned.dispatch(this);
			return !_cancelTransition;
		}

		protected function GetStateByType(targetType : String) : IState
		{
			for each (var i : IState in _subStates) 
			{
				if (i.type == targetType) return i;
			}
			return null;
		}
			
		/**
		 * Sets the machine's default state
		 * 
		 * @param state The state being removed from the machine
		 */
		public virtual function SetDefaultState(state : IState) : IState
		{
			if (!ContainState(state)) AddState(state);
			_defaultState = state;
			return state;
		}
		
		public function get currentState() : IState {
			return _currentState;
		}
		
		public function get lastState() : IState {
			return _lastState;
		}

		public function get defaultState() : IState {
			return _defaultState;
		}

		public function CancelTransition() : Boolean {
			if (_currentTransition && _currentTransition.cancellable) _cancelTransition = true;
			else _cancelTransition = false;
			return _cancelTransition;
		}

		public function ResetToDefault() : IState {
			if (_defaultState == null || _currentTransition != null) return null;
			
			if (_currentState)
			{
				_currentState.Exit();
			}
			_currentState = _defaultState;
			_currentState.Enter();
			return _currentState;
		}

		public function get toBeTransitioned() : ISignal {
			return _toBeTransitioned;
		}

		public function get currentTransition() : IStateTransition {
			return _currentTransition;
		}

		public function get transitioned() : ISignal {
			return _transitioned;
		}

		public function get stateEntering() : ISignal {
			return _stateEntering;
		}

		public function get stateExiting() : ISignal {
			return _stateExiting;
		}

		public function ContainStateWithName(stateId : String) : Boolean 
		{
			return GetStateByType(stateId) != null;
		}
		
	}
}

