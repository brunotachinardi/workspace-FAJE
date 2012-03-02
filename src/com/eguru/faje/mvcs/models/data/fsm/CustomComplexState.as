package com.eguru.faje.mvcs.models.data.fsm 
{
	import com.eguru.faje.mvcs.models.data.fsm.core.CustomEventBootstraper;
	import com.eguru.faje.mvcs.models.data.fsm.core.ICustomState;
	import com.eguru.faje.mvcs.services.factories.IStateFactory;
	import flash.events.IEventDispatcher;
	import com.eguru.faje.mvcs.models.data.fsm.core.CustomStateEventHandler;
	import com.eguru.faje.fsm.core.ComplexState;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomComplexState extends ComplexState implements ICustomState
	{
		
		public function CustomComplexState() 
		{
			super("");
		}
		
		protected var _customStateHandler : CustomStateEventHandler;
		protected var _saveScormOnStateChange : Boolean;
		protected var _saveStatusInScorm : Boolean;
		
		override public function Enter() : void
		{
			super.Enter();
			_customStateHandler.Enter();
		}
		
		override public function Update() : void
		{
			super.Update();
			_customStateHandler.Update();
		}
		
		override public function Exit() : void
		{
			super.Exit();
			_customStateHandler.Exit();
		}

		public virtual function Initialize(specification : Object, eventDispatcher : IEventDispatcher, stateFactory : IStateFactory) : void
		{
			_type = specification["name"];
			_customStateHandler = new CustomEventBootstraper().Initialize(specification, eventDispatcher, this);
			_saveScormOnStateChange = true;
			_saveStatusInScorm = true;
			
			if (specification.hasOwnProperty("saveScormOnStateChange"))
			{
				_saveScormOnStateChange = specification["saveScormOnStateChange"];
			}
			
			if (specification.hasOwnProperty("saveStatusInScorm"))
			{
				_saveStatusInScorm = specification["saveStatusInScorm"];
			}
			
			for each (var stateObject : Object in specification["states"]) 
			{
				var newState : ICustomState = stateFactory.GenerateState(stateObject, eventDispatcher);
				if (newState.type == specification["defaultState"]) _defaultState = newState;
				if (newState.type == specification["startingState"]) _currentState = newState;
				AddState(newState);
			}	
		}
		
		public function get saveScormOnStateChange() : Boolean
		{
			return _saveScormOnStateChange;
		}
		
		public function get saveStatusInScorm() : Boolean
		{
			return _saveStatusInScorm;
		}
	}
}
