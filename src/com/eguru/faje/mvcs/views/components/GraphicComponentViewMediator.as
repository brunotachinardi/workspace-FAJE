package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.mvcs.views.components.events.StopAnimationEvent;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class GraphicComponentViewMediator extends Mediator {
		
		[Inject]
		public var view : GraphicComponentView;
		
		override public function onRegister() : void
		{
			_eventDispatcher.addEventListener(StopAnimationEvent.STOP_ANIMATION, HandleStopAnimation);
		}

		private function HandleStopAnimation(event : StopAnimationEvent) : void 
		{
			view.StopAnimation(event.animationName);
		}
	}
}
