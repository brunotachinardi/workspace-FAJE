package com.eguru.faje.mvcs.controllers.bootstraps {
	import com.eguru.faje.fsm.core.StateMachine;
	import com.eguru.faje.fsm.core.IStateSystem;
	import org.robotlegs.core.IInjector;
	/**
	 * @author Bruno Tachinardi
	 */
	public class BootstrapClasses extends Object {
		
		public function BootstrapClasses(injector:IInjector)
        {
            injector.mapClass(IStateSystem, StateMachine);
        }
	}
}
