package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.mvcs.views.components.events.StopAnimationEvent;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class SoundComponentViewMediator extends Mediator {
		
		[Inject]
		public var view : SoundComponentView;
		
		override public function onRegister() : void
		{
			view.addEventListener(StopAnimationEvent.STOP_ANIMATION, HandleAnimationEnd);
		}

		private function HandleAnimationEnd(event : StopAnimationEvent) : void 
		{
			_eventDispatcher.dispatchEvent(new StopAnimationEvent(StopAnimationEvent.STOP_ANIMATION, event.animationName));
		}
	}
}
