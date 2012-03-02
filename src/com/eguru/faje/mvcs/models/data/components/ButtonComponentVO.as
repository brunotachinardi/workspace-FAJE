package com.eguru.faje.mvcs.models.data.components {
	import com.eguru.faje.mvcs.models.SoundModel;
	import com.eguru.faje.mvcs.models.data.DisplayPropertiesVO;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ButtonComponentVO extends ComponentVO 
	{
		//Text properties
		protected var _variableName : String;
		protected var _text : String;
		
		//Button Properties
		protected var _normal : TextBoxComponentVO;
		protected var _over : TextBoxComponentVO;
		protected var _pressed : TextBoxComponentVO;
		protected var _activeNormal : TextBoxComponentVO;
		protected var _activeOver : TextBoxComponentVO;
		protected var _activePressed : TextBoxComponentVO;
		protected var _disabled : TextBoxComponentVO;
		protected var _message : String;
		protected var _buttonState : String;

		protected var _models : SpecificationsModelsVO;
		
		//Sounds
		protected var _normalSound : String;
		protected var _overSound : String;
		protected var _pressedSound : String;
		protected var _activeNormalSound : String;
		protected var _activeOverSound : String;
		protected var _activePressedSound : String;
		protected var _soundsLayer : String;
		
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) : void
		{
			super.Initialize(specifications, models);
			_models = models;
			//Button Properties
			var normalImage : String;
			var overImage : String;
			var pressedImage : String;
			var activeNormalImage : String;
			var activeOverImage : String;
			var activePressedImage : String;
			var disabledImage : String;
			
			//Button Text Properties
			var normalTextProperties : String;
			var overTextProperties : String;
			var pressedTextProperties : String;
			var activeNormalTextProperties : String;
			var activeOverTextProperties : String;
			var activePressedTextProperties : String;
			var disabledTextProperties : String;
			
			_soundsLayer = SoundModel.INTERFACE_FX_SOUND_NAME;
			if (specifications.hasOwnProperty("soundsLayer"))
			{
				_soundsLayer = specifications["soundsLayer"];
			}
			
			_normalSound = null;
			if (specifications.hasOwnProperty("normalSound"))
			{
				_normalSound = specifications["normalSound"];
			}
			
			_overSound = null;
			if (specifications.hasOwnProperty("overSound"))
			{
				_overSound = specifications["overSound"];
			}
			
			_pressedSound = null;
			if (specifications.hasOwnProperty("pressedSound"))
			{
				_pressedSound = specifications["pressedSound"];
			}
			
			_activeNormalSound = null;
			if (specifications.hasOwnProperty("activeNormalSound"))
			{
				_activeNormalSound = specifications["activeNormalSound"];
			}
			
			_activeOverSound = null;
			if (specifications.hasOwnProperty("activeOverSound"))
			{
				_activeOverSound = specifications["activeOverSound"];
			}
			
			_activePressedSound = null;
			if (specifications.hasOwnProperty("activePressedSound"))
			{
				_activePressedSound = specifications["activePressedSound"];
			}
			
			
			_variableName = "";
			_text = "";
			
			if (specifications.hasOwnProperty("variable"))
			{
				_variableName = specifications["variable"] as String;
			}
			
			if (specifications.hasOwnProperty("text"))
			{
				_text = specifications["text"] as String;
			}
			
			overImage = pressedImage = activeNormalImage = activeOverImage = activePressedImage = disabledImage = normalImage = specifications["normal"];
			assetsNames.push(normalImage);
			
			overTextProperties = pressedTextProperties = activeNormalTextProperties = activeOverTextProperties = 
			activePressedTextProperties = disabledTextProperties = normalTextProperties = 
			specifications.hasOwnProperty("normalTextProperties") ? specifications["normalTextProperties"] : "default";
			
			_message = ButtonProperties.DEFAULT_BUTTON_MESSAGE;
			_state = ButtonProperties.NORMAL_STATE;
			
			if (specifications.hasOwnProperty("over"))
			{
				overImage = pressedImage = specifications["over"];
				assetsNames.push(overImage);
			}
			
			if (specifications.hasOwnProperty("pressed"))
			{
				pressedImage = specifications["pressed"];
				assetsNames.push(pressedImage);
			}
			
			if (specifications.hasOwnProperty("activeNormal"))
			{
				activeNormalImage = activeOverImage = activePressedImage = specifications["activeNormal"];
				assetsNames.push(activeNormalImage);
			}
			
			if (specifications.hasOwnProperty("activeOver"))
			{
				activeOverImage = activePressedImage = specifications["activeOver"];
				assetsNames.push(activeOverImage);
			}
			
			if (specifications.hasOwnProperty("activePressed"))
			{
				activePressedImage = specifications["activePressed"];
				assetsNames.push(activePressedImage);
			}
			
			if (specifications.hasOwnProperty("disabled"))
			{
				disabledImage = specifications["disabled"];
				assetsNames.push(disabledImage);
			}
			
			if (specifications.hasOwnProperty("message"))
			{
				_message = specifications["message"];
			}
			
			if (specifications.hasOwnProperty("initialState"))
			{
				switch(specifications["initialState"]){
					case ButtonProperties.ACTIVE_STATE:
						_buttonState = ButtonProperties.ACTIVE_STATE;				
						break;
						
					case ButtonProperties.DISABLED_STATE:
						_buttonState = ButtonProperties.DISABLED_STATE;				
						break;
					default:
				}
			}
			
			if (specifications.hasOwnProperty("overTextProperties"))
			{
				overTextProperties = pressedTextProperties = specifications["overTextProperties"];
			}
			
			if (specifications.hasOwnProperty("pressedTextProperties"))
			{
				pressedTextProperties = specifications["pressedTextProperties"];
			}
			
			if (specifications.hasOwnProperty("activeNormalTextProperties"))
			{
				activeNormalTextProperties = activeOverTextProperties = activePressedTextProperties = 
				specifications["activeNormalTextProperties"];
			}
			
			if (specifications.hasOwnProperty("activeOverTextProperties"))
			{
				activeOverTextProperties = activePressedTextProperties = 
				specifications["activeOverTextProperties"];
			}
			
			if (specifications.hasOwnProperty("activePressedTextProperties"))
			{
				activePressedTextProperties = specifications["activePressedTextProperties"];
			}
			
			if (specifications.hasOwnProperty("disabledTextProperties"))
			{
				disabledTextProperties = specifications["disabledTextProperties"];
			}
			
			_normal = SetTextBoxComponent(normalImage, normalTextProperties, "normal", models);
			_over = SetTextBoxComponent(overImage, overTextProperties, "over", models);
			_pressed = SetTextBoxComponent(pressedImage, pressedTextProperties, "pressed", models);
			_activeNormal = SetTextBoxComponent(activeNormalImage, activeNormalTextProperties, "activeNormal", models);
			_activeOver = SetTextBoxComponent(activeOverImage, activeOverTextProperties, "activeOver", models);
			_activePressed = SetTextBoxComponent(activePressedImage, activePressedTextProperties, "activePressed", models);
			_disabled = SetTextBoxComponent(disabledImage, disabledTextProperties, "disabled", models);
		}

		private function SetTextBoxComponent(image : String, textProperties : String, state : String, models : SpecificationsModelsVO) : TextBoxComponentVO 
		{
			var newTextBox : TextBoxComponentVO = new TextBoxComponentVO();
			var specifications : Object = 
			{
				name : _name + "::" + image + "::" + textProperties + "::state=" + state,
				variable : _variableName,
				text : _text,
				image : image,
				textProperties : textProperties				
			};
			newTextBox.Initialize(specifications, models);
			
			var displayPropertiesInfo : Object = 
			{
				name : _name + "::DisplayProperties",
				width : _displayProperties.width,
				height : _displayProperties.height
			};
			newTextBox.SetDisplayProperties(new DisplayPropertiesVO(displayPropertiesInfo));
			return newTextBox;
		}
		
		private function CloneComponent(component : TextBoxComponentVO) : TextBoxComponentVO 
		{
			var newTextBox : TextBoxComponentVO = new TextBoxComponentVO();
			
			newTextBox.Initialize(component.rawSpecification, _models);
			newTextBox.SetDisplayProperties(new DisplayPropertiesVO(component.displayProperties.rawSpecification));
			return newTextBox;
		}
		
		public function get variableName() : String
		{
			return _variableName;
		}
		
		public function get normal() : TextBoxComponentVO
		{
			return CloneComponent(_normal);
		}
		
		public function get over() : TextBoxComponentVO
		{
			return CloneComponent(_over);
		}
		
		public function get pressed() : TextBoxComponentVO
		{
			return CloneComponent(_pressed);
		}
		
		public function get activeNormal() : TextBoxComponentVO
		{
			return CloneComponent(_activeNormal);
		}
		
		public function get activeOver() : TextBoxComponentVO
		{
			return CloneComponent(_activeOver);
		}
		
		public function get activePressed() : TextBoxComponentVO
		{
			return CloneComponent(_activePressed);
		}
		
		public function get disabled() : TextBoxComponentVO
		{
			return CloneComponent(_disabled);
		}
		
		public function get normalSound() : String
		{
			return _normalSound;
		}
		
		public function get overSound() : String
		{
			return _overSound;
		}
		
		public function get pressedSound() : String
		{
			return _pressedSound;
		}
		
		public function get activeNormalSound() : String
		{
			return _activeNormalSound;
		}
		
		public function get activeOverSound() : String
		{
			return _activeOverSound;
		}
		
		public function get activePressedSound() : String
		{
			return _activePressedSound;
		}
		
		public function get soundsLayer() : String
		{
			return _soundsLayer;
		}
		
		public function get message() : String
		{
			return _message;
		}
		
		public function get buttonState() : String
		{
			return _buttonState;
		}
		
		public function SetState(newState : String) : Boolean
		{
			if (newState == _buttonState) return false;
			else _buttonState = newState;
			return true;
		}
		
	}
}
