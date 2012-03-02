package com.eguru.faje.fsm.core {
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IStateContainer 
	{
		/**
		 * Adds a new state to the machine.
		 * 
		 * @param state The state being added to the machine
		 * @return The target state
		 */
		function AddState(state : IState) : IState;
	
		/**
		 * Removes a state from the machine.
		 * 
		 * @param state The state being removed from the machine
		 * @return The target state
		 */
		function RemoveState(state : IState) : IState;
		
		/**
		 * Checks if the machine contains this state
		 * 
		 * @param state The state being checked
		 * @return The target state
		 */
		function ContainState(state : IState) : Boolean;
		
		function get states() : Vector.<IState>;
	}
}
