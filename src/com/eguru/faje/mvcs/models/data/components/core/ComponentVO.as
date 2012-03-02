package com.eguru.faje.mvcs.models.data.components.core {
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.eguru.faje.mvcs.models.data.DisplayPropertiesVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public class ComponentVO extends Object
	{
		protected var _assetsNames : Vector.<String>;
		protected var _displayProperties : DisplayPropertiesVO;
		protected var _defaultDisplayProperties : DisplayPropertiesVO;
		protected var _name : String;
		protected var _state : String;
		protected var _behaviour : String;
		protected var _rawSpecification : Object;
		
		public function Initialize(specifications : Object, models : SpecificationsModelsVO) :void
		{
			_rawSpecification = specifications;
			_name = specifications["name"] as String;
			_assetsNames = new Vector.<String>();
			_defaultDisplayProperties = _displayProperties = models.displayModel.GetDisplayPropertyByName(specifications["defaultDisplayProperties"] as String);
			_state = ComponentsStates.DISABLED;
			_behaviour = ComponentsBehaviours.PERSISTENT;
			if (specifications.hasOwnProperty("behaviour"))
			{
				switch(specifications["behaviour"]){
					case ComponentsBehaviours.WEAK:
						_behaviour = ComponentsBehaviours.WEAK;
						break;
					case ComponentsBehaviours.STRONG:
						_behaviour = ComponentsBehaviours.STRONG;
						break;
					default:
					_behaviour = ComponentsBehaviours.PERSISTENT;
				}
			}
		}
		
		public function get rawSpecification() : Object
		{
			return _rawSpecification;
		}
		
		public function get name() : String 
		{
			return _name;
		}
		
		public function get assetsNames() : Vector.<String> 
		{
			return _assetsNames;
		}
		
		public function get displayProperties() : DisplayPropertiesVO 
		{
			return _displayProperties;
		}
		
		public function get behaviour() : String
		{
			return _behaviour;
		}
		
		public function get defaultDisplayProperties() : DisplayPropertiesVO 
		{
			return _defaultDisplayProperties;
		}
		
		public function SetDisplayProperties(displayProperties : DisplayPropertiesVO) : void 
		{
			_displayProperties = displayProperties;
		}
		
		public function SetDefaultPropertiesName() : void 
		{
			SetDisplayProperties(_defaultDisplayProperties);
		}
		
		public function SetEnabled() : void 
		{
			_state = ComponentsStates.ENABLED;
		}
		
		public function SetDisabled() : void 
		{
			_state = ComponentsStates.DISABLED;
		}
		
		public function SetTransitioning() : void 
		{
			_state = ComponentsStates.TRANSITIONING;
		}
				
	}
}
