package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.mvcs.controllers.events.StateMachineEvent;
	import flash.events.MouseEvent;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ButtonComponentViewMediator extends Mediator 
	{
		[Inject]
		public var view : ButtonComponentView;
		
		override public function onRegister() : void
		{
			view.addEventListener(MouseEvent.CLICK, HandleMouseClick);
		}

		private function HandleMouseClick(event : MouseEvent) : void 
		{
			if (view.exiting) return;
			dispatch(new StateMachineEvent(view.message));
		}
	}
}
