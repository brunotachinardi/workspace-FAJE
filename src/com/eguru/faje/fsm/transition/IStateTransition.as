package com.eguru.faje.fsm.transition {
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IStateTransition {
		
		/**
		 * Adds a transition checker
		 */
		function AddChecker(checker : ITransitionChecker) : ITransitionChecker;
		
		/**
		 * Removes the specified checker
		 */
		function RemoveChecker(checker : ITransitionChecker) : ITransitionChecker;
		
		/**
		 * Checks if the transition contains this checker
		 */
		function ContainChecker(checker : ITransitionChecker) : Boolean;
		
		/**
		 * Checks if this transition must be triggered
		 */
		function CheckActivation() : Boolean;
		
		/**
		 * Priorities are used in order to make sure that, in case multiples 
		 * transitions are triggered at the same time, the one with the higher
		 * priority will be used instead of the others.
		 */
		function get priority() : int;
		
		/**
		 * Flags if the transition can be canceled at the guard phase
		 */
		function get cancellable() : Boolean;
		
		/**
		 * The id of the state holding this transition
		 */
		function get parentId() : String;
		
		/**
		 * The id of the state this transition points
		 */
		function get targetId() : String;
	}
}
