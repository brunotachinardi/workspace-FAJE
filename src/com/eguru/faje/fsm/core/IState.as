package com.eguru.faje.fsm.core {
	import com.eguru.faje.fsm.transition.IStateTransition;
	import org.osflash.signals.ISignal;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IState {
		
		
		/**
		 * The function called when this state enters (called by the StateMachine)
		 */
		function Enter() : void;
		
		/**
		 * The function called when this state exits (called by the StateMachine)
		 */
		function Exit() : void;
		
		/**
		 * The function called on state update (called by the StateMachine)
		 */
		function Update() : void;
		
		/**
		 * The function called to ask this state if it requires any transition (called by the StateMachine)
		 * 
		 * @return The type of the state that should be transitioned to
		 */
		function CheckTransitions() : IStateTransition;
		
		/*
		 * The type of the state (somehow acts like its id)
		 */
		function get type() : String;	
		
		/**
		 * Adds a transition to the transitions list
		 */
		function AddTransition(transition : IStateTransition) : IStateTransition;
		
		/**
		 * Removes a transition from the transitions list
		 */
		function RemoveTransition(transition : IStateTransition) : IStateTransition;
		
		/**
		 * Checks if the state already contains a trasition
		 */
		function ContainTransition(transition : IStateTransition) : Boolean;
		
		/**
		 * The state system to witch this state belongs
		 */
		function get parent() : IStateContainer;
		
		/**
		 * The state system to witch this state belongs
		 */
		function set parent(value : IStateContainer) : void;
		
		/*
		 * The entered signal
		 */
		function get entered() : ISignal;
		
		/*
		 * The exited signal
		 */
		function get exited() : ISignal;
		
		/*
		 * The updated signal
		 */
		function get updated() : ISignal;
	}
}
