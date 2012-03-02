package com.eguru.faje.mvcs.models.data.components {
	import com.eguru.faje.mvcs.models.data.components.core.TextComponentVO;
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TrackerTextComponentVO extends TextComponentVO 
	{
		private var _targetVarName : String;
		private var _sufix : String;
		private var _prefix : String;
		private var _separator : String;
		private var _showTotal : Boolean;
		private var _percentage : Boolean;
		private var _format : String;
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) : void
		{
			super.Initialize(specifications, models);
			
			_prefix = "";
			_sufix = "";
			_separator = "/";
			
			if (specifications.hasOwnProperty("sufix"))
			{
				_sufix = specifications["sufix"] as String;
			}
			
			if (specifications.hasOwnProperty("prefix"))
			{
				_prefix = specifications["prefix"] as String;
			}
			
			if (specifications.hasOwnProperty("showTotal"))
			{
				_showTotal = specifications["showTotal"] as Boolean;
			}	
			
			if (specifications.hasOwnProperty("percentage"))
			{
				_percentage = specifications["percentage"] as Boolean;
			}	
			
			if (specifications.hasOwnProperty("separator"))
			{
				_separator = specifications["separator"] as String;
			}

			if (specifications.hasOwnProperty("format"))
			{
				_format = specifications["format"] as String;
			}	
			
			_targetVarName = specifications["target"] as String;
		}
		
		
		public function get targetVarName() : String
		{
			return _targetVarName;
		}
		
		override public function GetText(args : Object = null) : String
		{
			if (args == null) throw new Error("Must pass an args object containing a value and a total properties");
			if (!args.hasOwnProperty("value")) throw new Error("Must pass a value property in the args variable");
			if (!args.hasOwnProperty("total")) throw new Error("Must pass a total property in the args variable");
			
			var value : Number = args["value"];
			var total : Number = args["total"];
			
			var finalValue : Number = _percentage ? (value/total)*100 : value;
			var finalTotal : Number = _percentage ? 100 : total;
			var text : String = "";
			text += _prefix;
			text += FormatNumber(finalValue);
			if (_showTotal) text += _separator + FormatNumber(finalTotal);
			text += _sufix ;
			
			return text;
		}

		private function FormatNumber(value : Number) : String {
			switch(_format){
				case TrackerTextComponentFormatOptions.COMMA:
					return FormatAtThousands(value, ",");
					break;
					
				case TrackerTextComponentFormatOptions.POINT:
					return FormatAtThousands(value, ".");
					break;
					
				case TrackerTextComponentFormatOptions.SPACE:
					return FormatAtThousands(value, " ");
					break;
					
				case TrackerTextComponentFormatOptions.TIME_HOURS:
					return FormatTime(value, HOURS);
					break;
					
				case TrackerTextComponentFormatOptions.TIME_MINUTES:
					return FormatTime(value, MINUTES);
					break;
					
				case TrackerTextComponentFormatOptions.TIME_SECONDS:
					return FormatTime(value, SECONDS);
					break;
					
				case TrackerTextComponentFormatOptions.NONE:
					return String(value);
					break;
					
				default:
				return String(value);
			}
		}

		private const HOURS : int = 2;
		private const MINUTES : int = 1;
		private const SECONDS : int = 0;
		
		private function FormatTime(time : Number, detailLevel : int = 2) : String {
			var intTime:uint = Math.floor(time);
			
			var hours:uint = Math.floor(intTime/ 3600);
			var minutes:uint = (intTime - (hours*3600))/60;
			var seconds:uint = intTime -  (hours*3600) - (minutes * 60);
			
			var hourString:String = detailLevel == HOURS ? ((hours < 10 ? "0" : "") + hours + ":"):"";
			var minuteString:String = detailLevel >= MINUTES ? ((minutes <10 ? "0":"") + minutes + ":"):"";
			var secondString:String = ((seconds < 10 && (detailLevel >= MINUTES)) ? "0":"") + seconds;
			
			return hourString + minuteString + secondString;
		}
		
		private function FormatAtThousands(value : Number, separator : String) : String {
			var original : String = String(value);
			var inversedString : String = "";
			var inverseIndex : int = 1;
			while (inverseIndex <= original.length)
			{
				inversedString += original.charAt(original.length - inverseIndex);
				if ((inverseIndex) % 3 == 0 && (inverseIndex + 1) <= original.length) inversedString += separator;
				inverseIndex++;
			}
			
			var finalString : String = "";
			inverseIndex = 1;
			while (inverseIndex <= inversedString.length)
			{
				finalString += inversedString.charAt(inversedString.length - inverseIndex);
				inverseIndex++;
			}
			
			return finalString;
		}
	}
}
