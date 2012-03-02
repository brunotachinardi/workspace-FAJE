package com.eguru.faje.mvcs.controllers.events {
	import com.eguru.faje.mvcs.models.data.ComponentActivationSpecVO;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ComponentModelEvent extends Event 
	{
		public static const MISSING_ASSETS : String = "ComponentModelEvent.MissingAssets";
		public static const COMPONENTS_ADDED : String = "ComponentModelEvent.ComponentsAdded";
		public static const COMPONENTS_REMOVED : String = "ComponentModelEvent.ComponentsRemoved";
		public static const COMPONENTS_PERSISTED : String = "ComponentModelEvent.ComponentsPersisted";
		public static const COMPONENTS_CHANGED : String = "ComponentModelEvent.ComponentsChanged";
		
		protected var _components : Vector.<ComponentVO>;
		protected var _activationSpec : ComponentActivationSpecVO;

        public function ComponentModelEvent(type:String, components : Vector.<ComponentVO>, activationSpec : ComponentActivationSpecVO)
        {
            super(type);
			_components = components;
			_activationSpec = activationSpec;
        }

        override public function clone():Event
        {
            return new ComponentModelEvent(type, _components, _activationSpec);
        }
		
		public function get components() : Vector.<ComponentVO>
		{
			return _components;
		}
		
		public function get activationSpec() : ComponentActivationSpecVO
		{
			return _activationSpec;
		}
	}
}
