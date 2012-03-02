package com.eguru.faje.mvcs.models.data.fsm {
	import com.eguru.faje.mvcs.services.factories.IStateFactory;
	import flash.events.IEventDispatcher;
	/**
	 * @author Bruno Tachinardi
	 */
	public class ComponentState extends CustomState
	{
		protected var _components : Vector.<StateComponentSpecVO>;
		
		public function ComponentState() 
		{
			_components = new Vector.<StateComponentSpecVO>();
		}
		
		override public function Initialize(specification : Object, dispatcher : IEventDispatcher, stateFactory : IStateFactory) : void
		{
			super.Initialize(specification, dispatcher, stateFactory);
			
			for each (var componentObj : Object in specification["components"]) 
			{
				_components.push(new StateComponentSpecVO(componentObj));
			}
		}
		
		public function get components() : Vector.<StateComponentSpecVO>
		{
			return _components;
		}
	}
}
