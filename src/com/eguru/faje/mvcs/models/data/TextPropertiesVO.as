package com.eguru.faje.mvcs.models.data {
	import com.eguru.faje.mvcs.models.TextVerticalAlignmentOptions;
	/**
	 * @author Bruno Tachinardi
	 */
	public class TextPropertiesVO 
	{
		protected var _name : String;		
		protected var _textColor : int;		
		protected var _font : String;		
		protected var _spacingLeft : Number;		
		protected var _spacingRight : Number;	
		protected var _spacingUp : Number;	
		protected var _spacingDown : Number;		
		protected var _align : String;
		protected var _verticalAlign : String;
		protected var _bold : Boolean;		
		protected var _size : int;
		protected var _italic : Boolean;
		protected var _underline : Boolean;
		protected var _textOffsetX : Number;
		protected var _textOffsetY : Number;
		private var _useBold : Boolean;
		private var _useUnderline : Boolean;
		private var _useItalic : Boolean;
		protected var _rawSpecifications : Object;
		protected var _html : Boolean;
		
		
		public function TextPropertiesVO(info : Object = null) 
		{
			_rawSpecifications = info;
			this._underline = false;
			this._textColor = NaN;
			this._font = null;
			this._spacingLeft = NaN;
			this._spacingRight = NaN;
			this._spacingUp = NaN;
			this._spacingDown = NaN;
			this._align = null;
			this._verticalAlign = null;
			this._bold = false;
			this._size = NaN;
			this._italic = false;
			this._textOffsetX = NaN;
			this._textOffsetY = NaN;
			
			this._html = false;
			
			if (info != null)
			{
				//Sets the name property
				if (info.hasOwnProperty("name"))
				{
					this._name = String(info["name"]);
				} else if (info.hasOwnProperty("n"))
				{
					this._name = String(info["n"]);
				}
				else throw new Error("The Text Properties Object must have a 'name' (or 'n') property!");
				
				//Sets the html property
				if (info.hasOwnProperty("html"))
				{
					this._html = Boolean(info["html"]);
				}
				
				//Sets the underline property
				if (info.hasOwnProperty("underline"))
				{
					this._underline = Boolean(info["underline"]);
					_useUnderline = true;
				} else if (info.hasOwnProperty("u"))
				{
					this._underline = Boolean(info["u"]);
					_useUnderline = true;
				}
				
				//Sets the textColor property
				if (info.hasOwnProperty("textColor"))
				{
					this._textColor = int(info["textColor"]);
				} else if (info.hasOwnProperty("tc"))
				{
					this._textColor = int(info["tc"]);
				}
				
				//Sets the font property
				if (info.hasOwnProperty("font"))
				{
					this._font = String(info["font"]);
				} else if (info.hasOwnProperty("f"))
				{
					this._font = String(info["f"]);
				}
				
				//Sets the spacingX property
				if (info.hasOwnProperty("spacingX"))
				{
					this._spacingLeft = Number(info["spacingX"]);
					this._spacingRight = Number(info["spacingX"]);
				} else if (info.hasOwnProperty("sx"))
				{
					this._spacingLeft = Number(info["sx"]);
					this._spacingRight = Number(info["sx"]);
				}
				
				//Sets the spacingY property
				if (info.hasOwnProperty("spacingY"))
				{
					this._spacingUp = Number(info["spacingY"]);
					this._spacingDown = Number(info["spacingY"]);
				} else if (info.hasOwnProperty("sy"))
				{
					this._spacingUp = Number(info["sy"]);
					this._spacingDown = Number(info["sy"]);
				}
				
				//Sets the spacingLeft property
				if (info.hasOwnProperty("spacingLeft"))
				{
					this._spacingLeft = Number(info["spacingLeft"]);
				} else if (info.hasOwnProperty("sl"))
				{
					this._spacingLeft = Number(info["sl"]);
				}
				
				//Sets the spacingRight property
				if (info.hasOwnProperty("spacingRight"))
				{
					this._spacingRight = Number(info["spacingRight"]);
				} else if (info.hasOwnProperty("sr"))
				{
					this._spacingRight = Number(info["sr"]);
				}
				
				//Sets the spacingUp property
				if (info.hasOwnProperty("spacingUp"))
				{
					this._spacingUp = Number(info["spacingUp"]);
				} else if (info.hasOwnProperty("su"))
				{
					this._spacingUp = Number(info["su"]);
				}
				
				//Sets the spacingDown property
				if (info.hasOwnProperty("spacingDown"))
				{
					this._spacingDown = Number(info["spacingDown"]);
				} else if (info.hasOwnProperty("sd"))
				{
					this._spacingDown = Number(info["sd"]);
				}
				
				//Sets the align property
				if (info.hasOwnProperty("align"))
				{
					this._align = String(info["align"]);
				} else if (info.hasOwnProperty("a"))
				{
					this._align = String(info["a"]);
				}
				if (this._align != null)
				{
					if (_align != TextHorizontalAlignmentOptions.CENTER &&
						_align != TextHorizontalAlignmentOptions.LEFT &&
						_align != TextHorizontalAlignmentOptions.RIGHT &&
						_align != TextHorizontalAlignmentOptions.JUSTIFY)
						throw new Error("Invalid align property '" + _align + "' in Text Properties '" + _name + "'. The property can only be set to: " + TextHorizontalAlignmentOptions.CENTER + ", " + TextHorizontalAlignmentOptions.RIGHT + ", " + TextHorizontalAlignmentOptions.LEFT + " or " + TextHorizontalAlignmentOptions.JUSTIFY + ".");
				}
				
				//Sets the vertical align property
				if (info.hasOwnProperty("verticalAlign"))
				{
					this._verticalAlign = String(info["verticalAlign"]);
				} else if (info.hasOwnProperty("va"))
				{
					this._verticalAlign = String(info["va"]);
				}
				if (this._verticalAlign != null)
				{
					if (_verticalAlign != TextVerticalAlignmentOptions.CENTER &&
						_verticalAlign != TextVerticalAlignmentOptions.UP &&
						_verticalAlign != TextVerticalAlignmentOptions.DOWN)
						throw new Error("Invalid verticalAlign property '" + _verticalAlign + "' in Text Properties '" + _name + "'. The property can only be set to: " + TextVerticalAlignmentOptions.CENTER + ", " + TextVerticalAlignmentOptions.DOWN + " or " + TextVerticalAlignmentOptions.UP + ".");
				}
				
				//Sets the bold property
				if (info.hasOwnProperty("bold"))
				{
					this._bold = Boolean(info["bold"]);
					_useBold = true;
				} else if (info.hasOwnProperty("b"))
				{
					this._bold = Boolean(info["b"]);
					_useBold = true;
				}
				
				//Sets the italic property
				if (info.hasOwnProperty("italic"))
				{
					this._italic = Boolean(info["italic"]);
					_useItalic = true;
				} else if (info.hasOwnProperty("i"))
				{
					this._italic = Boolean(info["i"]);
					_useItalic = true;
				}
				
				//Sets the size property
				if (info.hasOwnProperty("size"))
				{
					this._size = int(info["size"]);
				} else if (info.hasOwnProperty("s"))
				{
					this._size = int(info["s"]);
				}
				
				//Sets the textOffsetX
				if (info.hasOwnProperty("textOffsetX"))
				{
					this._textOffsetX = int(info["textOffsetX"]);
				} else if (info.hasOwnProperty("tox"))
				{
					this._textOffsetX = int(info["tox"]);
				}
				
				//Sets the textOffsetY
				if (info.hasOwnProperty("textOffsetY"))
				{
					this._textOffsetY = Number(info["textOffsetY"]);
				} else if (info.hasOwnProperty("toy"))
				{
					this._textOffsetY = Number(info["toy"]);
				}
			}
			else throw new Error("The Text Properties Object must have a 'name' (or 'n') property!");
			
		}
		
		public function get textOffsetX() : Number
		{
			return _textOffsetX;
		}
		
		public function get textOffsetY() : Number
		{
			return _textOffsetY;
		}
		
		public function get rawSpecifications() : Object
		{
			return _rawSpecifications;
		}
		
		public function get textColor() : int
		{
			return _textColor;
		}
		
		public function get font() : String
		{
			return _font;
		}
		
		public function get underline() : Boolean
		{
			return _underline;
		}
		
		public function get spacingX() : Number
		{
			return (_spacingLeft + _spacingRight)/2;
		}
		
		public function get spacingY() : Number
		{
			return (_spacingUp + _spacingDown) / 2;
		}
		
		public function get spacingLeft() : Number
		{
			return _spacingLeft;
		}
		
		public function get spacingRight() : Number
		{
			return _spacingRight;
		}
		
		public function get spacingUp() : Number
		{
			return _spacingUp;
		}
		
		public function get spacingDown() : Number
		{
			return _spacingDown;
		}
		
		public function get align() : String
		{
			return _align;
		}
		
		public function get verticalAlign() : String
		{
			return _verticalAlign;
		}
		
		public function get bold() : Boolean
		{
			return _bold;
		}
		
		public function get useBold() : Boolean
		{
			return _useBold;
		}
		
		public function get useItalic() : Boolean
		{
			return _useItalic;
		}
		
		public function get useUnderline() : Boolean
		{
			return _useUnderline;
		}
		
		public function get size() : int
		{
			return _size;
		}
		
		public function get italic() : Boolean
		{
			return _italic;
		}
		
		public function get name() : String
		{
			return _name;
		}
		
		public function get html() : Boolean
		{
			return _html;
		}
	}
}
