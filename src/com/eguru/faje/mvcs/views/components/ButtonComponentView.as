package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.utils.sound.core.ISoundObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.DisplayObject;
	import com.eguru.faje.mvcs.models.data.components.ButtonProperties;
	import com.eguru.faje.mvcs.views.components.core.ComponentView;
	import flash.display.SimpleButton;
	import com.eguru.faje.mvcs.models.data.components.ButtonComponentVO;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;


	/**
	 * @author Bruno Tachinardi
	 */
	public class ButtonComponentView extends ComponentView 
	{
		private var _buttonVO : ButtonComponentVO;
		private var _normalButton : SimpleButton;
		private var _activeButton : SimpleButton;
		private var _disabledButton : TextBoxComponentView;
		private var _active : DisplayObject;
		
		
		private var _currentMouseState : String;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			_buttonVO = componentVO as ButtonComponentVO;
			
			var normalView : TextBoxComponentView = new TextBoxComponentView();
			normalView.Initialize(_buttonVO.normal, assets);
			_childrenList.push(normalView);
			normalView.addEventListener(Event.ADDED_TO_STAGE, NormalViewAdded);
			
			var overView : TextBoxComponentView = new TextBoxComponentView();
			overView.Initialize(_buttonVO.over, assets);
			_childrenList.push(overView);
			overView.addEventListener(Event.ADDED_TO_STAGE, OverViewAdded);
			
			var pressedView : TextBoxComponentView = new TextBoxComponentView();
			pressedView.Initialize(_buttonVO.pressed, assets);
			_childrenList.push(pressedView);
			pressedView.addEventListener(Event.ADDED_TO_STAGE, PressedViewAdded);
			
			var hitTestView : TextBoxComponentView = new TextBoxComponentView();
			hitTestView.Initialize(_buttonVO.normal, assets);
			_childrenList.push(hitTestView);
			
			var activeNormalView : TextBoxComponentView = new TextBoxComponentView();
			activeNormalView.Initialize(_buttonVO.activeNormal, assets);
			_childrenList.push(activeNormalView);
			activeNormalView.addEventListener(Event.ADDED_TO_STAGE, ActiveNormalViewAdded);
			
			var activeOverView : TextBoxComponentView = new TextBoxComponentView();
			activeOverView.Initialize(_buttonVO.activeOver, assets);
			_childrenList.push(activeOverView);
			activeOverView.addEventListener(Event.ADDED_TO_STAGE, ActiveOverViewAdded);
			
			var activePressedView : TextBoxComponentView = new TextBoxComponentView();
			activePressedView.Initialize(_buttonVO.activePressed, assets);
			_childrenList.push(activePressedView);
			activePressedView.addEventListener(Event.ADDED_TO_STAGE, ActivePressedViewAdded);
			
			var activeHitTestView : TextBoxComponentView = new TextBoxComponentView();
			activeHitTestView.Initialize(_buttonVO.activeNormal, assets);
			_childrenList.push(activeHitTestView);
			
			var disabledView : TextBoxComponentView = new TextBoxComponentView();
			disabledView.Initialize(_buttonVO.disabled, assets);
			_childrenList.push(disabledView);
			
			
			_normalButton = new SimpleButton();
			_normalButton.upState = normalView;
			_normalButton.overState = overView;
			_normalButton.downState = pressedView;
			_normalButton.hitTestState = hitTestView;
								
			_activeButton = new SimpleButton();
			_activeButton.upState = activeNormalView;
			_activeButton.overState = activeOverView;
			_activeButton.downState = activePressedView;
			_activeButton.hitTestState = activeHitTestView;
								
			_disabledButton = disabledView;
			_disabledButton.mouseEnabled = false;
			_disabledButton.mouseChildren = false;
			_disabledButton.addEventListener(MouseEvent.CLICK, StopDisabledClick);
			addEventListener(MouseEvent.CLICK, StopDisabledClick);
			
			switch(_buttonVO.buttonState){
				case ButtonProperties.NORMAL_STATE:
					addChild(_normalButton);
					_active = _normalButton;
					break;
				case ButtonProperties.ACTIVE_STATE:
					addChild(_activeButton);
					_active = _activeButton;
					break;
				case ButtonProperties.DISABLED_STATE:
					addChild(_disabledButton);
					_active = _disabledButton;
					break;
				default:
					addChild(_normalButton);
					_active = _normalButton;
			}
			_currentMouseState = ButtonProperties.UP_STATE;
			super.Initialize(componentVO, assets);
		}

		private function ActivePressedViewAdded(event : Event) : void 
		{
			if (hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, UpdateUpState);
			_currentMouseState = ButtonProperties.DOWN_STATE;
			if (_buttonVO.activePressedSound == null) return;
			PlaySoundOnce(_buttonVO.activePressedSound, _buttonVO.soundsLayer);
		}

		private function ActiveOverViewAdded(event : Event) : void 
		{
			if (hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, UpdateUpState);
			if (_buttonVO.activeOverSound == null || _currentMouseState != ButtonProperties.UP_STATE) {
				_currentMouseState = ButtonProperties.OVER_STATE;
				return;
			}
			_currentMouseState = ButtonProperties.OVER_STATE;
			PlaySoundOnce(_buttonVO.activeOverSound, _buttonVO.soundsLayer);
		}

		private function ActiveNormalViewAdded(event : Event) : void 
		{
			if (hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, UpdateUpState);		
			if (_buttonVO.activeNormalSound == null) return;
			PlaySoundOnce(_buttonVO.activeNormalSound, _buttonVO.soundsLayer);
		}

		private function PressedViewAdded(event : Event) : void 
		{
			if (hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, UpdateUpState);
			_currentMouseState = ButtonProperties.DOWN_STATE;			
			if (_buttonVO.pressedSound == null) return;
			PlaySoundOnce(_buttonVO.pressedSound, _buttonVO.soundsLayer);
		}

		private function OverViewAdded(event : Event) : void 
		{
			if (hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, UpdateUpState);
			if (_buttonVO.overSound == null || _currentMouseState != ButtonProperties.UP_STATE) {
				_currentMouseState = ButtonProperties.OVER_STATE;
				return;			
			}
			_currentMouseState = ButtonProperties.OVER_STATE;
			PlaySoundOnce(_buttonVO.overSound, _buttonVO.soundsLayer);
		}

		private function NormalViewAdded(event : Event) : void 
		{
			if (hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, UpdateUpState);
			addEventListener(Event.ENTER_FRAME, UpdateUpState);		
			if (_buttonVO.normalSound == null) return;			
			PlaySoundOnce(_buttonVO.normalSound, _buttonVO.soundsLayer);
		}

		private function UpdateUpState(event : Event) : void 
		{
			_currentMouseState = ButtonProperties.UP_STATE;	
			removeEventListener(Event.ENTER_FRAME, UpdateUpState);
		}
		
		private function StopDisabledClick(event : MouseEvent) : void 
		{
			if (_buttonVO.buttonState != ButtonProperties.DISABLED_STATE) return;
			event.stopImmediatePropagation();
		}
		
		override public function ApplyProperties() : void 
		{
			_componentVO.displayProperties.InvalidateSizeModifiers();
			super.ApplyProperties();
			_componentVO.displayProperties.RevalidateSizeModifiers();
		}
		
		public function SetState(newState : String) : void
		{
			if (_buttonVO.SetState(newState))
			{
				if (_active != null && contains(_active)) removeChild(_active);
					switch(newState){
						case ButtonProperties.ACTIVE_STATE:
							addChild(_activeButton);
							_active = _activeButton;
							break;
						case ButtonProperties.NORMAL_STATE:
							addChild(_normalButton);
							_active = _normalButton;
							break;
						case ButtonProperties.DISABLED_STATE:
							addChild(_disabledButton);
							_active = _disabledButton;
							break;
						default:
					}
			}
		}
		
		public function get message() : String
		{
			return _buttonVO.message;
		}
	}
}
