package com.eguru.faje.fsm.core {
	import com.eguru.faje.fsm.transition.IStateTransition;
	import org.osflash.signals.ISignal;
	/**
	 * @author Bruno Tachinardi
	 * @lang Actionscript 3
	 * 
	 * Interface used to handle states systems
	 */
	public interface IStateSystem extends IStateContainer, IState {
		
		/**
		 * The current active state
		 */
		function get currentState() : IState;
		
		/**
		 * The current transition
		 */
		function get currentTransition() : IStateTransition;
		
		/**
		 * The default state (whenever the machine encounters itself without a currentState, it will activate this state)
		 */
		function get defaultState() : IState;
		
		function get lastState() : IState;
		
		/**
		 * Sets the machine's default state
		 * 
		 * @param state The state being removed from the machine
		 */
		function SetDefaultState(state : IState) : IState;		
		
		function TransitionToState(stateId : String) : void;
		
		function ContainStateWithName(stateId : String) : Boolean;
		
		function CancelTransition() : Boolean;
		
		function ResetToDefault() : IState;
		
		function get toBeTransitioned() : ISignal;
		
		function get transitioned() : ISignal;
		
		function get stateEntering() : ISignal;
		
		function get stateExiting() : ISignal;
	}
}
