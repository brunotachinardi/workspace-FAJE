package com.eguru.faje.mvcs.models.data {
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public class PreloaderConfigVO 
	{
		protected var _components : Vector.<ComponentVO>;
		
		public function PreloaderConfigVO(components : Vector.<ComponentVO>) 
		{
			_components = new Vector.<ComponentVO>();
			for each (var c : ComponentVO in components) {
				_components.push(c);
			}
		}
		
		public function get components() : Vector.<ComponentVO>
		{
			return _components;
		}
	}
}
