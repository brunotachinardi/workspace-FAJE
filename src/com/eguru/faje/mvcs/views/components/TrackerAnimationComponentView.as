package com.eguru.faje.mvcs.views.components {
	import flash.events.Event;
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import flash.display.MovieClip;
	import com.eguru.faje.mvcs.models.data.components.TrackerAnimationComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TrackerAnimationComponentView extends AnimationComponentView {
		
		protected var _trackerVO : TrackerAnimationComponentVO;
		protected var _animation : MovieClip;
		protected var _waitingPercentage : Number;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			super.Initialize(componentVO, assets);
			
			_trackerVO = componentVO as TrackerAnimationComponentVO;
			UpdateBar(0)
			if (_animatedMC == null) addEventListener(Event.ENTER_FRAME, WaitForMC);			
		}

		private function WaitForMC(event : Event) : void 
		{			
			if (_animatedMC != null)
			{
				UpdateBar(_waitingPercentage);
				removeEventListener(Event.ENTER_FRAME, WaitForMC);
			}
		}
		
		
		public function UpdateVariable(vars : IAppNumberVariableModel) : void 
		{
			var currentValue : Number = vars.GetVariableValue(_trackerVO.targetVarName);
			var currentTotal : Number = vars.GetVariableMax(_trackerVO.targetVarName);
			UpdateBar(currentValue / currentTotal);
		}
		
		public function CheckVariableUpdate(name : String, value : Number, total : Number) : void
		{
			if (name != _trackerVO.targetVarName) return;
			if (!isNaN(_trackerVO.defaultMaximum)) total = _trackerVO.defaultMaximum;
			UpdateBar(value / total);
		}

		private function UpdateBar(percentage : Number) : void 
		{
			if (_animatedMC == null) 
			{
				_waitingPercentage = percentage;
				return;
			}
			var targetFrame : int = Math.floor(percentage * _animatedMC.totalFrames);
			_animatedMC.gotoAndStop(targetFrame);
		}
	}
}
