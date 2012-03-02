package com.eguru.faje.mvcs.views 
{
	import com.eguru.faje.mvcs.controllers.events.DebugEvent;
	import com.eguru.faje.mvcs.services.factories.IComponentFactory;
	import com.eguru.faje.mvcs.controllers.events.ComponentModelEvent;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class StageManagerViewMediator extends Mediator 
	{
		
		[Inject]
		public var view : StageManagerView;
		
		[Inject]
		public var factory : IComponentFactory;
			
		override public function onRegister() : void
		{
			addContextListener(ComponentModelEvent.COMPONENTS_ADDED, AddComponents, ComponentModelEvent);
			addContextListener(ComponentModelEvent.COMPONENTS_PERSISTED, PersistComponents, ComponentModelEvent);
			addContextListener(ComponentModelEvent.COMPONENTS_REMOVED, RemoveComponents, ComponentModelEvent);
			addContextListener(ComponentModelEvent.COMPONENTS_CHANGED, UpdateComponents, ComponentModelEvent);
			addContextListener(DebugEvent.ACTIVATE_CPU_STATS, ActivateCpuStats, DebugEvent);
		}

		private function ActivateCpuStats(event : DebugEvent) : void 
		{
			view.ActivateCpuStats();
		}
		
		protected function AddComponents(event : ComponentModelEvent) : void
        {
			view.AddComponents(event.components, event.activationSpec, factory);
		}
		
		protected function PersistComponents(event : ComponentModelEvent) : void
        {
			view.PersistComponents(event.components, event.activationSpec, factory);
		}
		
		protected function RemoveComponents(event : ComponentModelEvent) : void
        {
			view.RemoveComponents(event.components, event.activationSpec, factory);
		}
		
		protected function UpdateComponents(event : ComponentModelEvent) : void
        {
			view.UpdateStage();
		}
	}
}
