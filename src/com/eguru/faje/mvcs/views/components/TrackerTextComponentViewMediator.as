package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.controllers.events.AppNumberVariableModelEvent;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TrackerTextComponentViewMediator extends Mediator 
	{
		[Inject]
		public var view : TrackerTextComponentView;
		
		[Inject]
		public var vars : IAppNumberVariableModel;
		
		override public function onRegister() : void
		{
			addContextListener(AppNumberVariableModelEvent.VARIABLE_CHANGED, UpdateText, AppNumberVariableModelEvent);
			view.UpdateVariable(vars);
		}		
		
		protected function UpdateText(event : AppNumberVariableModelEvent) : void 
		{	
			if (view.exiting) return;		
			view.CheckVariableUpdate(event.name, event.value, event.max);
		}
	}
}
