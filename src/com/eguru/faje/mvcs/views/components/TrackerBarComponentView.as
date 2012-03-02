package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import com.eguru.faje.mvcs.models.data.components.TrackerBarComponentVO;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.views.components.core.ComponentView;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TrackerBarComponentView extends ComponentView 
	{
		protected var _trackerVO : TrackerBarComponentVO;
		protected var _background : DisplayObject;
		protected var _bar : DisplayObject;
		protected var _border : DisplayObject;
		
		protected var _barMask : Sprite;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			super.Initialize(componentVO, assets);
			
			_trackerVO = componentVO as TrackerBarComponentVO;
			if (_trackerVO.backgroundImageName != null) _background = assets.GetAssetContentByName(_trackerVO.backgroundImageName) as DisplayObject;
			_bar = assets.GetAssetContentByName(_trackerVO.barImageName) as DisplayObject;
			if (_trackerVO.borderImageName != null) _border = assets.GetAssetContentByName(_trackerVO.borderImageName) as DisplayObject;
			
			_barMask = new Sprite();
			_barMask.graphics.beginFill(0x000000);
			_barMask.graphics.drawRect(0, 0, _bar.width, _bar.height);
			_barMask.graphics.endFill();
			_bar.mask = _barMask;
			
			if (_background != null) addChild(_background);
			addChild(_bar);
			if (_border != null) addChild(_border);
			addChild(_barMask);
			
			UpdateBar(0);		
			
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
			percentage = Math.min(Math.max(percentage, 0), 1);
			_barMask.x = -_bar.width * (1 - percentage);
			
			_barMask.graphics.clear();
			_barMask.graphics.beginFill(0x000000);
			_barMask.graphics.drawRect(0, 0, _bar.width, _bar.height);
			_barMask.graphics.endFill();
		}
	}
}
