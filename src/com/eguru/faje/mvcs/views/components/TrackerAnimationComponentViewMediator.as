package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.mvcs.controllers.events.AppNumberVariableModelEvent;
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TrackerAnimationComponentViewMediator extends Mediator 
	{
		[Inject]
		public var view : TrackerAnimationComponentView;
		
		[Inject]
		public var vars : IAppNumberVariableModel;
		
		override public function onRegister() : void
		{
			addContextListener(AppNumberVariableModelEvent.VARIABLE_CHANGED, UpdateBar, AppNumberVariableModelEvent);
			view.UpdateVariable(vars);
		}
		
		protected function UpdateBar(event : AppNumberVariableModelEvent) : void 
		{		
			if (view.exiting) return;	
			view.CheckVariableUpdate(event.name, event.value, event.max);
		}
	}
}
