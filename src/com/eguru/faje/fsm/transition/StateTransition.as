package com.eguru.faje.fsm.transition {
	import com.eguru.faje.fsm.transition.IStateTransition;
	import com.eguru.faje.fsm.transition.ITransitionChecker;

	/**
	 * @author Bruno Tachinardi
	 */
	public class StateTransition implements IStateTransition {
		
		protected var _checkers : Vector.<ITransitionChecker>;
		protected var _priority : int;
		protected var _cancellable : Boolean;
		protected var _parentId : String;
		protected var _targetId : String;
		
		public function StateTransition(parentId : String, targetId : String, priority : int = 0, cancellable : Boolean = true) {
			_checkers = new Vector.<ITransitionChecker>();
			_parentId = parentId;
			_targetId = targetId;
			_cancellable = cancellable;
			_priority = priority;
		}
		
		public function AddChecker(checker : ITransitionChecker) : ITransitionChecker {
			if (ContainChecker(checker)) return checker;
			_checkers.push(checker);
			return checker;
		}

		public function RemoveChecker(checker : ITransitionChecker) : ITransitionChecker {
			var length : int = _checkers.length;
			for (var i : int = 0; i <  length; i++) {
				if (_checkers[i] == checker) {
					_checkers.splice(i, 1);					
					break;
				}
			}		
			return checker;
		}
		
		public function ContainChecker(checker : ITransitionChecker) : Boolean {
			return _checkers.indexOf(checker) != -1;
		}

		public function CheckActivation() : Boolean {
			for each (var i : ITransitionChecker in _checkers) {
				if (!i.Check()) return false;
			}
			return true;
		}

		public function get priority() : int {
			return _priority;
		}

		public function get cancellable() : Boolean {
			return _cancellable;
		}

		public function get parentId() : String {
			return _parentId;
		}

		public function get targetId() : String {
			return _targetId;
		}		
	}
}
