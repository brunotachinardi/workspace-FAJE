package com.eguru.faje.mvcs.models {
	import org.robotlegs.mvcs.Actor;

	import com.eguru.faje.mvcs.models.IDisplayPropertiesModel;
	import com.eguru.faje.mvcs.models.data.DisplayPropertiesVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class DisplayPropertiesModel extends Actor implements IDisplayPropertiesModel {
		
		protected var _displayProperties : Vector.<DisplayPropertiesVO>;
		protected var _defaultProperties : DisplayPropertiesVO;
		
		public function DisplayPropertiesModel() 
		{
			_displayProperties = new Vector.<DisplayPropertiesVO>();
		}

		public function AddDisplayProperty(dp : DisplayPropertiesVO) : DisplayPropertiesVO {
			if (ContainDisplayProperty(dp)) return dp;
			if (ContainDisplayPropertyByName(dp.name)) throw new Error("The Display Property name '" + dp.name + "' is already assigned to an existing display properties object. Please rename one of them as names should be unique.");
			_displayProperties.push(dp);
			if (dp.name == "default") _defaultProperties = dp;
			return dp;
		}
		
		public function AddDisplayPropertyGroup(dps : Vector.<DisplayPropertiesVO>) : void 
		{
			for each (var dp : DisplayPropertiesVO in dps) 
			{
				AddDisplayProperty(dp);				
			}
		}

		public function RemoveDisplayProperty(dp : DisplayPropertiesVO) : DisplayPropertiesVO {
			if (!ContainDisplayProperty(dp)) return dp;
			_displayProperties.splice(_displayProperties.indexOf(dp), 1);
			return dp;
		}

		public function ContainDisplayProperty(dp : DisplayPropertiesVO) : Boolean {
			return _displayProperties.indexOf(dp) != -1;
		}

		public function ContainDisplayPropertyByName(name : String) : Boolean {
			for each (var i : DisplayPropertiesVO in _displayProperties) {
				if (i.name == name) return true;
			}
			return false;
		}

		public function GetDisplayPropertyByName(name : String) : DisplayPropertiesVO {
			for each (var i : DisplayPropertiesVO in _displayProperties) {
				if (i.name == name) return i;
			}
			if (_defaultProperties == null) throw new Error("The display properties named '" + name + "' was not found and no default value was set!");
			return _defaultProperties;
		}

		public function AddRawDisplayPropertyGroup(displayPropertiesArray : Array) : Vector.<DisplayPropertiesVO> 
		{
			var displayProperties : Vector.<DisplayPropertiesVO> = new Vector.<DisplayPropertiesVO>();
			for each (var d : Object in displayPropertiesArray) 
			{
				var displayPropertiesVO : DisplayPropertiesVO = new DisplayPropertiesVO(d);
				displayProperties.push(displayPropertiesVO);
			}
			AddDisplayPropertyGroup(displayProperties);
			return displayProperties;
		}
	}
}
