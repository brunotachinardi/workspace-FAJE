package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.mvcs.views.components.events.StopAnimationEvent;
	import com.eguru.faje.mvcs.controllers.events.StateMachineEvent;
	import com.eguru.faje.mvcs.views.components.events.AnimationComponentViewEvent;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class AnimationComponentViewMediator extends Mediator 
	{
		[Inject]
		public var view : AnimationComponentView;
		
		override public function onRegister() : void
		{
			view.addEventListener(AnimationComponentViewEvent.ANIMATION_END, HandleAnimationEnd);
			_eventDispatcher.addEventListener(StopAnimationEvent.STOP_ANIMATION, HandleStopAnimation);
		}

		private function HandleStopAnimation(event : StopAnimationEvent) : void 
		{
			view.StopAnimation(event.animationName);
		}

		private function HandleAnimationEnd(event : AnimationComponentViewEvent) : void 
		{
			if (view.exiting) return;
			dispatch(new StateMachineEvent(event.eventname));
		}
	}
}
