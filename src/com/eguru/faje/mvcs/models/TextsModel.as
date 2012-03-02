package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.controllers.events.TextsVariableEvent;
	import com.eguru.faje.mvcs.models.data.TextVO;
	import org.robotlegs.mvcs.Actor;

	import com.eguru.faje.mvcs.models.ITextsModel;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TextsModel extends Actor implements ITextsModel {
		
		protected var _feeds : Object;
		protected var _variables : Vector.<TextVO>;
		
		public function TextsModel() 
		{
			_feeds = new Object();
			_variables = new Vector.<TextVO>();
		}

		public function AddTextFeed(feed : Object) : void 
		{
			for (var key : String in feed)
			{
				if (_feeds.hasOwnProperty(key)) throw new Error("The text feed object already contains a text linked to the key '" + key + "', please check your text feeds and make sure the keys are unique.");
				_feeds[key] = feed[key];
			}
		}

		public function GetVariableValue(name : String) : String {
			return GetVariableByName(name).value;
		}

		public function SetVariable(name : String, value : String) : String 
		{
			var variable : TextVO = GetVariableByName(name);
			Set(variable, value);
			return variable.value;			
		}
		
		private function GetVariableByName(name : String) : TextVO
		{
			for each (var v : TextVO in _variables) {
				if (v.name == name) return v;
			}
			var variable : TextVO = new TextVO(name);
			_variables.push(variable);
			return variable;
		}
		
		private function Set(variable : TextVO, value : String) : void
		{
			if (variable.SetValue(value))
			{
				var event : TextsVariableEvent = new TextsVariableEvent(TextsVariableEvent.VARIABLE_CHANGED, variable);
				dispatch(event);
			}
		}

		public function SetVariableByFeed(name : String, feed : String) : String 
		{
			if (!_feeds.hasOwnProperty(feed)) throw new Error("The text feed with key '" + feed + "' was not registered. Please verify if this is the correct key to the feed or if you have correctly added it.");
			var variable : TextVO = GetVariableByName(name);
			Set(variable, _feeds[feed]);
			return variable.value;
		}
	}
}
