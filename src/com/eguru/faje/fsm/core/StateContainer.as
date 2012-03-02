package com.eguru.faje.fsm.core {
	/**
	 * @author Bruno Tachinardi
	 */
	public class StateContainer extends State implements IStateContainer {
		
		protected var _subStates : Vector.<IState>;
		
		public function StateContainer(type : String) 
		{
			_subStates = new Vector.<IState>();
			super(type);
		}
		
		/**
		 * Adds a new state to the machine.
		 * 
		 * @param state The state being added to the machine
		 * @return The target state
		 */
		public virtual function AddState(state : IState) : IState
		{
			if (ContainState(state)) return null;
			_subStates.push(state);	
			state.parent = this;	
			return state;	
		}
	
		/**
		 * Removes a state from the machine.
		 * 
		 * @param state The state being removed from the machine
		 * @return The target state
		 */
		public virtual function RemoveState(state : IState) : IState
		{
			if (state.parent != this) return state;
			var length : int = _subStates.length;
			for (var i : int = 0; i <  length; i++) {
				if (_subStates[i] == state) {
					_subStates.splice(i, 1);					
					break;
				}
			}		
			state.parent = null;
			return state;
		}
			
		
		public function ContainState(state : IState) : Boolean 
		{
			return _subStates.indexOf(state) != -1;
		}
		
		public function get states() : Vector.<IState>
		{
			return _subStates;
		}
		
	}
}
