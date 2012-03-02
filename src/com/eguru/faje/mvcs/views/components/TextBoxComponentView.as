package com.eguru.faje.mvcs.views.components {
	import flash.events.Event;
	import com.eguru.faje.mvcs.models.ITextsModel;
	import flash.display.DisplayObject;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.models.data.components.TextBoxComponentVO;
	import com.eguru.faje.mvcs.views.components.core.TextComponentView;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TextBoxComponentView extends TextComponentView 
	{
		protected var _textBoxVO : TextBoxComponentVO;
		protected var _background : DisplayObject;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			_textBoxVO = componentVO as TextBoxComponentVO;	
			_defaultTextArgs = {text : _textBoxVO.text};	
			
			if (_textBoxVO.backgroundImagename != null && _textBoxVO.backgroundImagename != "")
			{
				_background = addChild(assets.GetAssetContentByName(_textBoxVO.backgroundImagename));
				addEventListener(Event.ENTER_FRAME, WaitForBackground);
			}
			
			super.Initialize(componentVO, assets);			
		}

		private function WaitForBackground(event : Event) : void 
		{
			if (_background.width != 0)
			{
				ApplyProperties();
				removeEventListener(Event.ENTER_FRAME, WaitForBackground);
			}
		}
		
		override public function ApplyProperties() : void
		{
			if (!isNaN(_componentVO.displayProperties.width) && _background != null)
			{
				_background.width = _componentVO.displayProperties.width;
			}
			
			if (!isNaN(_componentVO.displayProperties.height) && _background != null)
			{
				_background.height = _componentVO.displayProperties.height;
			}
			super.ApplyProperties();
		}
		
		override protected virtual function GetTextFieldWidth() : Number 
		{
			var totalWidth : Number;
			if (!isNaN(_componentVO.displayProperties.width))
			{
				totalWidth = _componentVO.displayProperties.width;
				return totalWidth;
			} 
			else if (_background != null)
			{
				totalWidth = _background.width;
				return totalWidth;
			}
			return _textField.width;
		}
		
		override protected virtual function GetTextFieldHeight() : Number 
		{
			var totalHeight : Number;
			if (!isNaN(_componentVO.displayProperties.height))
			{
				totalHeight = _componentVO.displayProperties.height;
				totalHeight -= (_spacingUp + _spacingDown);
				return  totalHeight;
			}
			else if (_background != null)
			{
				totalHeight = _background.height;
				totalHeight -= (_spacingUp + _spacingDown);
				return  totalHeight;
			}
			return _textField.height;
		}
		
		public function UpdateVariable(vars : ITextsModel) : void 
		{
			UpdateText({text : vars.GetVariableValue(_textBoxVO.variableName)});
		}
		
		public function CheckVariableUpdate(name : String, value : String) : void
		{
			if (name != _textBoxVO.variableName) return;
			UpdateText({text : value});
		}
	}
}
