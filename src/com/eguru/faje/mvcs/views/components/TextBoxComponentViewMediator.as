package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.mvcs.controllers.events.TextsVariableEvent;
	import com.eguru.faje.mvcs.models.ITextsModel;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TextBoxComponentViewMediator extends Mediator 
	{
		[Inject]
		public var view : TextBoxComponentView;
		
		[Inject]
		public var vars : ITextsModel;
		
		override public function onRegister() : void
		{
			addContextListener(TextsVariableEvent.VARIABLE_CHANGED, UpdateText, TextsVariableEvent);
			view.UpdateVariable(vars);
		}		
		
		protected function UpdateText(event : TextsVariableEvent) : void 
		{		
			if (view.exiting) return;	
			view.CheckVariableUpdate(event.variable.name, event.variable.value);
		}
	}
}
