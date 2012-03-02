package com.eguru.faje.mvcs.models.data {
	import com.eguru.faje.mvcs.models.data.fsm.core.ICustomState;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public class SpecificationsParseResultVO 
	{
		private var _components : Vector.<ComponentVO>;
		private var _displayProperties : Vector.<DisplayPropertiesVO>;
		private var _textProperties : Vector.<TextPropertiesVO>;
		private var _assets : Vector.<AssetVO>;
		private var _states : Vector.<ICustomState>;

		public function SpecificationsParseResultVO(componentsList : Vector.<ComponentVO>, 
													displayPropertiesList : Vector.<DisplayPropertiesVO>, 
													textPropertiesList : Vector.<TextPropertiesVO>, 
													assetsList : Vector.<AssetVO>, 
													statesList : Vector.<ICustomState>) 
		{
			_components = componentsList;
			_displayProperties = displayPropertiesList;
			_textProperties = textPropertiesList;
			_assets = assetsList;
			_states = statesList;
		}
		
		public function get components() : Vector.<ComponentVO>
		{
			return _components;
		}
		
		public function get displayProperties() : Vector.<DisplayPropertiesVO>
		{
			return _displayProperties;
		}
		
		public function get textProperties() : Vector.<TextPropertiesVO>
		{
			return _textProperties;
		}
		
		public function get assets() : Vector.<AssetVO>
		{
			return _assets;
		}
		
		public function get states() : Vector.<ICustomState>
		{
			return _states;
		}
	}
}
