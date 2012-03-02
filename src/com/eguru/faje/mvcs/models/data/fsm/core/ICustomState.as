package com.eguru.faje.mvcs.models.data.fsm.core {
	import com.eguru.faje.mvcs.services.factories.IStateFactory;
	import com.eguru.faje.fsm.core.IState;
	import flash.events.IEventDispatcher;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface ICustomState extends IState
	{
		function Initialize(specification : Object, eventDispatcher : IEventDispatcher, stateFactory : IStateFactory) : void;
	}
}
