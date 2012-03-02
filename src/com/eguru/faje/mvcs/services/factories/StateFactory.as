package com.eguru.faje.mvcs.services.factories {
	import flash.events.IEventDispatcher;
	import com.eguru.faje.mvcs.models.data.fsm.core.ICustomState;
	import com.eguru.faje.mvcs.models.data.fsm.core.StateMap;
	import com.eguru.faje.mvcs.services.factories.IStateFactory;

	/**
	 * @author Bruno Tachinardi
	 */
	public class StateFactory implements IStateFactory {
		
		protected var _maps : Vector.<StateMap>;
		
		public function StateFactory() 
		{
			_maps = new Vector.<StateMap>();			
		}
		
		public function GenerateState(specifications : Object, dispatcher : IEventDispatcher) : ICustomState {
			var map : StateMap = GetMapByName(specifications["type"] as String);
			var state : ICustomState = new map.stateClass() as ICustomState;
			state.Initialize(specifications["spec"], dispatcher, this);			
			return state;
		}

		public function MapState(stateName : String, stateClass : Class) : void 
		{
			for each (var map : StateMap in _maps) {
				if (map.name == stateName) throw new Error("This state name is already mapped!");
				if (map.stateClass == stateClass) throw new Error("This state class is already mapped!");
			}
			
			_maps.push(new StateMap(stateName, stateClass));	
		}
		
		private function GetMapByName(name : String) : StateMap {
			for each (var map : StateMap in _maps) {
				if (map.name == name) return map;
			}
			throw new Error("The state name '" + name + "' was not mapped!");
		}
	}
}
