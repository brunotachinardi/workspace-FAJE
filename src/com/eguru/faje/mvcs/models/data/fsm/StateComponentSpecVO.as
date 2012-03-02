package com.eguru.faje.mvcs.models.data.fsm {
	/**
	 * @author Bruno Tachinardi
	 */
	public class StateComponentSpecVO 
	{
		protected var _componentName : String;
		protected var _displaySpecificationName : String;
		
		public function StateComponentSpecVO(specification : Object) 
		{
			_componentName = specification["name"];
			
			if (specification.hasOwnProperty("displayProperties"))
			{
				_displaySpecificationName = specification["displayProperties"];	
			}
			
		}
		
		public function get componentName() : String
		{
			return _componentName;
		}
		
		public function get displaySpecificationName() : String
		{
			return _displaySpecificationName;
		}
	}
}
