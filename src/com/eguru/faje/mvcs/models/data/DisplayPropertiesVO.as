package com.eguru.faje.mvcs.models.data {
	import com.eguru.faje.mvcs.services.factories.IFiltersFactory;
	/**
	 * @author Bruno Tachinardi
	 */
	public class DisplayPropertiesVO 
	{
		[Inject]
		public var filtersFactory : IFiltersFactory;
		
		protected var _x : Number;		
		protected var _y : Number;		
		protected var _width : Number;		
		protected var _height : Number;		
		protected var _rotation : Number;		
		protected var _pivotX : Number;
		protected var _pivotY : Number;		
		protected var _alpha : Number;
		protected var _depth : Number;
		protected var _name : String;
		protected var _filters : Array;
		private var _oldWidth : Number;
		private var _oldHeight : Number;
		private var _rawSpecification : Object;
		
		public function DisplayPropertiesVO(info : Object = null) 
		{
			this._rawSpecification = info;
			this._x = NaN;
			this._y = NaN;
			this._width = NaN;
			this._height = NaN;
			this._rotation = NaN;
			this._pivotX = NaN;
			this._pivotY = NaN;
			this._alpha = NaN;
			this._depth = NaN;
			this._filters = new Array();
			
			if (info != null)
			{
				//Sets the x property
				if (info.hasOwnProperty("x"))
				{
					this._x = Number(info["x"]);
				}
				
				//Sets the y property
				if (info.hasOwnProperty("y"))
				{
					this._y = Number(info["y"]);
				}
				
				//Sets the width property
				if (info.hasOwnProperty("width"))
				{
					this._width = Number(info["width"]);
				}
				//Alternative setter to the width property
				else if (info.hasOwnProperty("w"))
				{
					this._width = Number(info["w"]);
				}
				
				//Sets the height property
				if (info.hasOwnProperty("height"))
				{
					this._height = Number(info["height"]);
				}
				//Alternative setter to the height property
				else if (info.hasOwnProperty("h"))
				{
					this._height = Number(info["h"]);
				}
				
				//Sets the rotation property
				if (info.hasOwnProperty("rotation"))
				{
					this._rotation = Number(info["rotation"]);
				}
				//Alternative setter to the rotation property
				else if (info.hasOwnProperty("r"))
				{
					this._rotation = Number(info["r"]);
				}
				
				//Sets the pivotX property
				if (info.hasOwnProperty("pivotX"))
				{
					this._pivotX = Number(info["pivotX"]);
				}
				//Alternative setter to the pivotX property
				else if (info.hasOwnProperty("px"))
				{
					this._pivotX = Number(info["px"]);
				}
				
				//Sets the pivotY property
				if (info.hasOwnProperty("pivotY"))
				{
					this._pivotY = Number(info["pivotY"]);
				}
				//Alternative setter to the pivotY property
				else if (info.hasOwnProperty("py"))
				{
					this._pivotY = Number(info["py"]);
				}
				
				//Sets the alpha property
				if (info.hasOwnProperty("alpha"))
				{
					this._alpha = Number(info["alpha"]);
				}
				//Alternative setter to the alpha property
				else if (info.hasOwnProperty("a"))
				{
					this._alpha = Number(info["a"]);
				}
				
				//Sets the depth property
				if (info.hasOwnProperty("depth"))
				{
					this._depth = Number(info["depth"]);
				}
				//Alternative setter to the alpha property
				else if (info.hasOwnProperty("d"))
				{
					this._depth = Number(info["d"]);
				}
				
				//Sets the name property
				if (info.hasOwnProperty("name"))
				{
					this._name = String(info["name"]);
				}
				//Alternative setter to the name property
				else if (info.hasOwnProperty("n"))
				{
					this._name = String(info["n"]);
				}
				else 
				{
					throw new Error("The Display Properties Object must have a 'name' (or 'n') property!");
				}
				
				//Sets the filters property
				var filters : Array;
				if (info.hasOwnProperty("filters"))
				{
					filters = info["filters"] as Array;
				}
				//Alternative filters to the name property
				else if (info.hasOwnProperty("f"))
				{
					filters = info["f"] as Array;
				}
				if (filters != null)
				{
					for each (var obj : Object in filters) 
					{
						this._filters.push(filtersFactory.ParseFilter(obj));
					}
				}				
			}
			else 
			{
				throw new Error("The Display Properties Object must have a 'name' (or 'n') property!");
			}			
		}
		
		public function get rawSpecification() : Object
		{
			return _rawSpecification;
		}
		
		public function get x() : Number 
		{
			return _x;
		}
		
		public function get y() : Number 
		{
			return _y;
		}
		
		public function get width() : Number 
		{
			return _width;
		}
		
		public function get height() : Number 
		{
			return _height;
		}
		
		public function get rotation() : Number 
		{
			return _rotation;
		}
		
		public function get pivotX() : Number 
		{
			return _pivotX;
		}
		
		public function get pivotY() : Number 
		{
			return _pivotY;
		}
		
		public function get alpha() : Number 
		{
			return _alpha;
		}
		
		public function get depth() : Number 
		{
			return _depth;
		}
		
		public function get name() : String 
		{
			return _name;
		}
		
		public function get filters() : Array
		{
			return _filters;
		}
		
		public function InvalidateSizeModifiers() : void
		{
			_oldWidth = _width;
			_width = NaN;
			_oldHeight = _height;
			_height = NaN;
		}
		
		public function RevalidateSizeModifiers() : void
		{
			_height = _oldHeight;
			_width = _oldWidth;
		}
	}
}
