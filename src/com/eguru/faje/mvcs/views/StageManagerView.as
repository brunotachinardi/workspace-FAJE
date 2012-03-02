package com.eguru.faje.mvcs.views 
{
	import net.hires.debug.Stats;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentsBehaviours;
	import com.greensock.TweenLite;
	import com.eguru.faje.mvcs.services.factories.IComponentFactory;
	import com.eguru.faje.mvcs.views.components.core.ComponentView;
	import com.eguru.faje.mvcs.models.data.ComponentActivationSpecVO;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import flash.display.Sprite;

	/**
	 * @author Bruno Tachinardi
	 */
	public class StageManagerView extends Sprite 
	{
		public static var TWEEN_DURATION : Number = 0.5;
		public static var RANDOM_DELAY : Number = 0;
		public static var TWEEN_ENTER : Object = { alpha : 0 };
		public static var TWEEN_EXIT : Object = { alpha : 0 };
		
		protected var _tweens : Vector.<TweenLite>;
		
		protected var _componentsViews : Vector.<ComponentView>;
		
		public function StageManagerView() 
		{
			_tweens = new Vector.<TweenLite>();
			_componentsViews = new Vector.<ComponentView>();
		}
		
		public function AddComponents(components : Vector.<ComponentVO>, activationSpec : ComponentActivationSpecVO, componentFactory : IComponentFactory) : void
		{
			for each (var c : ComponentVO in components) 
			{
				var newView : ComponentView = componentFactory.GenerateComponentView(c);
				AddComponentView(newView);
			}
		}
		
		public function PersistComponents(components : Vector.<ComponentVO>, activationSpec : ComponentActivationSpecVO, componentFactory : IComponentFactory) : void
		{
			for each (var c : ComponentVO in components) 
			{
				var newView : ComponentView = componentFactory.GenerateComponentView(c, true);
				
				if (c.behaviour == ComponentsBehaviours.WEAK)
				{
					RemoveComponentView(GetView(c));
					AddComponentView(newView);
				}
				else
				{
					PersistComponentView(newView);
				}
			}
		}
				
		public function RemoveComponents(components : Vector.<ComponentVO>, activationSpec : ComponentActivationSpecVO, componentFactory : IComponentFactory) : void
		{
			//Fades the views alpha
			for each (var c : ComponentVO in components) 
			{
				RemoveComponentView(GetView(c));
			}
		}
		
		private function AddComponentView(view : ComponentView) : void 
		{							
			_componentsViews.push(view);
			if (view.vo.behaviour == ComponentsBehaviours.STRONG)
			{
				CompleteTween(view);
				view.RestoreProperties();
				PersistComponentView(view);
			}
			view.Enter(TWEEN_DURATION);
			_tweens.push(TweenLite.from(view, TWEEN_DURATION, GetEnterObject(view)));
		}		
		
		
		private function PersistComponentView(view : ComponentView) : void 
		{
			view.ApplyProperties();
			//_tweens.push(TweenLite.to(view, TWEEN_DURATION, GetPersistObject(view)));
		}

		
		private function RemoveComponentView(view : ComponentView) : void 
		{
			if (view.vo.behaviour == ComponentsBehaviours.STRONG)
			{
				CompleteTween(view);
				view.SaveProperties();
			}
			view.Exit(TWEEN_DURATION);
			
			_tweens.push(TweenLite.to(view, TWEEN_DURATION, GetExitObject(view)));
			view.exiting = true;
		}
		
		private function FinishTweenObject(tweenObj : Object) : Object 
		{
			if(!tweenObj.hasOwnProperty("delay")) tweenObj.delay = 0;
			tweenObj.delay += ((Math.random() - 0.5) * 2) * RANDOM_DELAY;
			tweenObj.delay = tweenObj.delay < 0 ? 0 : tweenObj.delay;
			return tweenObj;
		}
		
		
		private function GetPersistObject(view : ComponentView) : Object {
			var tweenSpec : Object = view.GetTweenProperties();
			var array : Array = new Array();
			array.push(view);
			
			tweenSpec.onComplete = HandlePersistComplete;
			tweenSpec.onCompleteParams = array;	
			return FinishTweenObject(tweenSpec);
		}
		
		private function GetEnterObject(view : ComponentView) : Object 
		{
			var array : Array = new Array();
			array.push(view);
			var tweenSpec : Object = new Object();
			
			for (var key : String in TWEEN_ENTER) 
			{
				tweenSpec[key] = TWEEN_ENTER[key];
			}
			
			tweenSpec.onComplete = HandleEnterComplete;
			tweenSpec.onCompleteParams = array;	
			return FinishTweenObject(tweenSpec);
		}
		

		private function GetExitObject(view : ComponentView) : Object 
		{
			var array : Array = new Array();
			array.push(view);
			var tweenSpec : Object = new Object();
			
			for (var key : String in TWEEN_EXIT) 
			{
				tweenSpec[key] = TWEEN_EXIT[key];
			}
			
			tweenSpec.onComplete = HandleFadeComplete;
			tweenSpec.onCompleteParams = array;		
			
			return FinishTweenObject(tweenSpec);
		}

		private function GetView(c : ComponentVO) : ComponentView 
		{
			for each (var view : ComponentView in _componentsViews) 
			{
				if (view.vo == c) return view;
			}
			return null;
		}
		
		private function CompleteTween(target : ComponentView) : void
		{
			var currentTween : TweenLite = GetTween(target);
			if (currentTween != null) currentTween.complete();
		}

		private function DeleteTween(target : ComponentView) : void
		{
			for each (var tween : TweenLite in _tweens) 
			{
				if (tween.target == target) 
				{
					_tweens.splice(_tweens.indexOf(tween), 1);
					return;
				}
			}
		}
		
		private function GetTween(target : ComponentView) : TweenLite
		{
			for each (var tween : TweenLite in _tweens) 
			{
				if (tween.target == target) return tween;
			}
			return null;
		}
		
		private function HandleEnterComplete(target : ComponentView) : void
		{
			DeleteTween(target);
		}

		private function HandlePersistComplete(target : ComponentView) : void
		{
			DeleteTween(target);
		}
		
		private function HandleFadeComplete(target : ComponentView) : void
		{
			_componentsViews.splice(_componentsViews.indexOf(target), 1);
			removeChild(target);
			DeleteTween(target);
			target.exiting = false;
		}
		
		public function UpdateStage() : void
		{
			_componentsViews.sort(function(obj1 : ComponentView, obj2 : ComponentView) : int 
			{ 
				return obj1.depth > obj2.depth ? 1 : -1;
			});
			
			for each (var view : ComponentView in _componentsViews) 
			{
				addChild(view);				
			}
		}
		
		public function ActivateCpuStats()
		{
			if (parent != null) parent.addChild(new Stats());
		}
	}
}
