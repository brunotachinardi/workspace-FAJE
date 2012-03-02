package com.eguru.faje.utils.geom 
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	/**
	 * @author Bruno Tachinardi
	 */
	public class Grid2D 
	{
		private var _x : Number;
		private var _y : Number;	
		private var _columns : int;
		private var _offsetX : Number;
		private var _offsetY : Number;
	
		private var _counter : int;
	
		public function Grid2D(columns : int, offsetX : Number, offsetY : Number, x : Number = 0, y : Number = 0) : void
		{
			_columns = columns;
			_offsetX = offsetX;
			_offsetY = offsetY;
			_x = x;
			_y = y;
			_counter = 0;
		}
		
		
		public function Apply(target : DisplayObject) : void 
		{
			var position : Point = GetNextPos();
			target.x = position.x;
			target.y = position.y;
		}
		
		public function GetNextPos() : Point
		{
			var pos : Point = new Point();
			var row : int = Math.floor(_counter / _columns); 
			var col : int = _counter % _columns;
				
			pos.x = _x + (col * _offsetX);
			pos.y = _y + (row * _offsetY);
			_counter++;
				
			return pos;
		}
		
		public function Clear() : void 
		{
			_counter = 0;
		}
	}
}
