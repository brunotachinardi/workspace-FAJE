package com.eguru.faje.mvcs.views.components.core {
	import com.eguru.faje.mvcs.models.TextVerticalAlignmentOptions;
	import flash.utils.getDefinitionByName;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextField;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.models.data.components.core.TextComponentVO;
	import com.eguru.faje.mvcs.views.components.core.ComponentView;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TextComponentView extends ComponentView {
		
		protected var _textComponentVO : TextComponentVO;
		protected var _textField : TextField;
		protected var _defaultTextArgs : Object;
		protected var _spacingUp : Number;
		protected var _spacingDown : Number;
		protected var _spacingLeft : Number;
		protected var _spacingRight : Number;
		protected var _verticalAlign : String;
		protected var _textOffsetX : Number;
		protected var _textOffsetY : Number;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			_textComponentVO = componentVO as TextComponentVO;
			
			_spacingUp = 0;
			_spacingDown = 0;
			_textOffsetX = 0;
			_textOffsetY = 0;
			_verticalAlign = TextVerticalAlignmentOptions.UP;
			
			_textField = new TextField();
			
			_textField.autoSize = TextFieldAutoSize.NONE;
			_textField.wordWrap = true;
			_textField.multiline = true;
			_textField.selectable = false;
			_textField.width = 250;
			_textField.height = 150;
			_textField.embedFonts = true;
            _textField.antiAliasType = AntiAliasType.ADVANCED;
			addChild(_textField);
			super.Initialize(componentVO, assets);
			UpdateText(_defaultTextArgs);
		}
		
		
		public function get textvo() : TextComponentVO
		{
			return _textComponentVO;
		}
		
		override public function ApplyProperties() : void
		{
			_componentVO.displayProperties.InvalidateSizeModifiers();
			super.ApplyProperties();
			_componentVO.displayProperties.RevalidateSizeModifiers();
			
			ApplyTextProperties();
			AlignText();
		}

		protected virtual function GetTextFieldWidth() : Number 
		{
			if (!isNaN(_componentVO.displayProperties.width))
			{
				var totalWidth : Number = _componentVO.displayProperties.width;
				return totalWidth;
			}
			return _textField.width;
		}
		
		protected virtual function GetTextFieldHeight() : Number 
		{
			if (!isNaN(_componentVO.displayProperties.height))
			{
				var totalHeight : Number = _componentVO.displayProperties.height;
				totalHeight -= (_spacingUp + _spacingDown);
				return totalHeight;
			}
			return _textField.height;
		}
		
		protected function ApplyTextProperties() : void
		{
			var format : TextFormat = CloneFormat(_textField.getTextFormat());
			
			
			if (_textComponentVO.textProperties.align != null)
			{
				format.align = _textComponentVO.textProperties.align;
			}
			
			if (_textComponentVO.textProperties.verticalAlign != null)
			{
				_verticalAlign = _textComponentVO.textProperties.verticalAlign;
			}
			
			if (_textComponentVO.textProperties.useBold)
			{
				format.bold = _textComponentVO.textProperties.bold;
			}
			
			if (_textComponentVO.textProperties.useUnderline)
			{
				format.underline = _textComponentVO.textProperties.underline;
			}
			
			if (_textComponentVO.textProperties.useItalic)
			{
				format.italic = _textComponentVO.textProperties.italic;
			}
			
			if (_textComponentVO.textProperties.font != null)
			{
				var fontClass : Class = getDefinitionByName(_textComponentVO.textProperties.font) as Class;
				Font.registerFont(fontClass);
				var font : Font = new fontClass() as Font;
				format.font = font.fontName;
			}
			
			if (!isNaN(_textComponentVO.textProperties.size))
			{
				format.size = _textComponentVO.textProperties.size;
			}
			
			if (!isNaN(_textComponentVO.textProperties.spacingLeft))
			{
				format.leftMargin = _textComponentVO.textProperties.spacingLeft;
				_spacingLeft = _textComponentVO.textProperties.spacingLeft;
			}
			
			if (!isNaN(_textComponentVO.textProperties.spacingRight))
			{
				format.rightMargin = _textComponentVO.textProperties.spacingRight;
				_spacingRight = _textComponentVO.textProperties.spacingRight;
			}
			
			if (!isNaN(_textComponentVO.textProperties.spacingUp))
			{
				_spacingUp = _textComponentVO.textProperties.spacingUp;
			}
			
			if (!isNaN(_textComponentVO.textProperties.spacingDown))
			{
				_spacingDown = _textComponentVO.textProperties.spacingDown;
			}
			
			if (!isNaN(_textComponentVO.textProperties.textColor))
			{
				format.color = _textComponentVO.textProperties.textColor;
			}
			
			if (!isNaN(_textComponentVO.textProperties.textOffsetX))
			{
				_textOffsetX = _textComponentVO.textProperties.textOffsetX;
			}
			
			if (!isNaN(_textComponentVO.textProperties.textOffsetY))
			{
				_textOffsetY = _textComponentVO.textProperties.textOffsetY;
			}
			
			_textField.defaultTextFormat = format;		
		}

		private function CloneFormat(targetFormat : TextFormat) : TextFormat 
		{
			return new TextFormat(
									targetFormat.font,
									targetFormat.size,
									targetFormat.color,
									targetFormat.bold,
									targetFormat.italic,
									targetFormat.underline,
									targetFormat.url,
									targetFormat.target,
									targetFormat.align,
									targetFormat.leftMargin,
									targetFormat.rightMargin,
									targetFormat.indent,
									targetFormat.leading
									
									);
		}
		
		protected function UpdateText(args : Object = null) : void 
		{
			if (!_activated) return;
			
			if (_textComponentVO.html)
				_textField.htmlText = _textComponentVO.GetText(args);
			else
				_textField.text = _textComponentVO.GetText(args);
				
			AlignText();
		}

		protected function AlignText() : void 
		{
			
			_textField.width = GetTextFieldWidth();
			_textField.height = GetTextFieldHeight();
			
			switch(_verticalAlign){
				case TextVerticalAlignmentOptions.CENTER:
					AlignCenter();
					break;
					
				case TextVerticalAlignmentOptions.UP:
					AlignUp();
					break;
					
				case TextVerticalAlignmentOptions.DOWN:
					AlignDown();
					break;
				default:
					AlignUp();
			}
			
			_textField.y += _textOffsetY;
			_textField.x = _textOffsetX;
		}
		
		protected virtual function AlignDown() : void 
		{
			_textField.y = (_spacingUp + _textField.height) - (_textField.textHeight);			
		}
		protected virtual function AlignUp() : void 
		{
			_textField.y = _spacingUp;
		}
		protected virtual function AlignCenter() : void 
		{
			_textField.y = ((_textField.height + _spacingUp + _spacingDown) / 2) - (_textField.textHeight / 2);
		}
	}
}
