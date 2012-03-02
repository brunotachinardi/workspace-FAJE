package com.eguru.faje.mvcs.models.data.components.core {
	import com.eguru.faje.mvcs.views.components.core.ComponentView;
	/**
	 * @author Bruno Tachinardi
	 */
	public class ComponentMap extends Object 
	{
		private var _name : String;
		private var _voClass : Class;
		private var _viewClass : Class;
		
		public function ComponentMap(name : String, voClass : Class, viewClass : Class) 
		{
			if (!(new voClass() is ComponentVO)) throw new Error("The VO Class must extend ComponentVO!");
			if (viewClass != null && !(new viewClass() is ComponentView)) throw new Error("The view Class must extend ComponentView!");
			
			_name = name;
			_voClass = voClass;
			_viewClass = viewClass;
		}
		
		public function get name() : String
		{
			return _name;
		}
		
		public function get voClass() : Class
		{
			return _voClass;
		}
		
		public function get viewClass() : Class
		{
			return _viewClass;
		}
	}
}
