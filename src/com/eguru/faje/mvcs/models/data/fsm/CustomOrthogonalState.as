package com.eguru.faje.mvcs.models.data.fsm {
	import com.eguru.faje.mvcs.models.data.fsm.core.CustomEventBootstraper;
	import com.eguru.faje.mvcs.services.factories.IStateFactory;
	import com.eguru.faje.mvcs.models.data.fsm.core.CustomStateEventHandler;
	import flash.events.IEventDispatcher;
	import com.eguru.faje.mvcs.models.data.fsm.core.ICustomState;
	import com.eguru.faje.fsm.core.OrthogonalState;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomOrthogonalState extends OrthogonalState implements ICustomState
	{

		public function CustomOrthogonalState() 
		{
			super("");
		}
		
		protected var _customStateHandler : CustomStateEventHandler;
		
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
			for each (var stateObject : Object in specification["states"]) 
			{
				var newState : ICustomState = stateFactory.GenerateState(stateObject, eventDispatcher);
				AddState(newState);
			}	
		}
	}
}
