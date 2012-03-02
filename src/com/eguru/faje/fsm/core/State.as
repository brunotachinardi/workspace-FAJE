package com.eguru.faje.fsm.core {
	import com.eguru.faje.fsm.transition.IStateTransition;
	import org.osflash.signals.Signal;
	import org.osflash.signals.ISignal;

	/**
	 * The basic state used in any State Machine
	 *
	 *@author Bruno Tachinardi
	 *@langversion Actionscript 3
	 */
	 
	public class State implements IState
	{
		protected var _type : String;
		protected var _transitions : Vector.<IStateTransition>;
		protected var _exited : ISignal;
		protected var _entered : ISignal;
		protected var _updated : ISignal;
		protected var _parent : IStateContainer;
		
		/**
		 * The constructor of the class 
		 * 
		 * @param type The type of the state
		 */	
		public function State (type : String) 
		{
			_type = type;
			_transitions = new Vector.<IStateTransition>();
			_exited = new Signal(IState);
			_entered = new Signal(IState);
			_updated = new Signal(IState);
		}		
		
		public virtual function Enter() : void 
		{
			_entered.dispatch(this);
		}
		
		public virtual function Exit() : void 
		{
			_exited.dispatch(this);
		}
		
		public virtual function Update() : void 
		{
			_updated.dispatch(this);
		}
		
		public virtual function CheckTransitions() : IStateTransition {
			var transitionsTriggered : Vector.<IStateTransition> = new Vector.<IStateTransition>();
			for each (var i : IStateTransition in _transitions) {
				if (i.CheckActivation()) transitionsTriggered.push(i);
			}
			
			if (transitionsTriggered.length > 0)
			{
				var highestPriority : int = -99999;
				var highestTransition : IStateTransition;
				for each (var j : IStateTransition in transitionsTriggered) {
					if (j.priority > highestPriority)
					{
						highestPriority = j.priority;
						highestTransition = j;
					}
				}
				return highestTransition;
			}
			return null;
		}
		
		public function AddTransition(transition : IStateTransition) : IStateTransition {
			if (ContainTransition(transition)) return transition;
			_transitions.push(transition);
			return transition;
		}

		public function RemoveTransition(transition : IStateTransition) : IStateTransition {
			var length : int = _transitions.length;
			for (var i : int = 0; i <  length; i++) {
				var iterated : IStateTransition  = _transitions[i];
				if (iterated == transition) {
					_transitions.splice(i, 1);
					break;
				}
			}		
			return transition;
		}

		public function ContainTransition(transition : IStateTransition) : Boolean {
			return _transitions.indexOf(transition) != -1;
		}

		public function get type() : String {
			return _type;
		}

		public function get entered() : ISignal {
			return _entered;
		}

		public function get exited() : ISignal {
			return _exited;
		}

		public function get updated() : ISignal {
			return _updated;
		}

		public function get parent() : IStateContainer {
			return _parent;
		}
		
		public function set parent(value : IStateContainer) : void
		{
			_parent = value;
		}
		
	}


}
