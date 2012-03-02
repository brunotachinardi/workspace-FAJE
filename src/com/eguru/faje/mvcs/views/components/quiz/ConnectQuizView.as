package com.eguru.faje.mvcs.views.components.quiz {
	import com.eguru.faje.mvcs.models.data.quiz.QuizType;
	import com.eguru.faje.mvcs.views.components.events.MultiAlternativesEvent;
	import com.eguru.faje.mvcs.models.data.quiz.QuizAnswerVO;
	import com.eguru.faje.mvcs.models.data.quiz.QuizAlternativeVO;
	import com.eguru.faje.mvcs.models.data.components.ButtonProperties;
	import com.eguru.faje.mvcs.models.data.components.quiz.utils.QuizConnectionVO;
	import flash.display.Sprite;
	import flash.events.Event;
	import com.eguru.faje.mvcs.views.components.GraphicComponentView;
	import flash.events.MouseEvent;
	import com.eguru.faje.mvcs.models.data.components.ButtonComponentVO;
	import com.eguru.faje.mvcs.views.components.ButtonComponentView;
	import com.eguru.faje.mvcs.models.data.components.quiz.ConnectQuizVO;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.controllers.events.QuizFeedEvent;
	import com.eguru.faje.mvcs.views.components.quiz.BaseQuizComponentView;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ConnectQuizView extends BaseQuizComponentView 
	{
		protected var _connectVO : ConnectQuizVO;
		protected var _firstAlternatives : Vector.<ButtonComponentView>;
		protected var _secondAlternatives : Vector.<ButtonComponentView>;
		
		protected var _firstImageBackgroundImage : GraphicComponentView;
		
		protected var _firstTextBackgroundImage : GraphicComponentView;
		protected var _secondTextBackgroundImage : GraphicComponentView;
		protected var _firstConnectAlternatives : Vector.<ButtonComponentView>;
		protected var _secondConnectAlternatives : Vector.<ButtonComponentView>;
		
		protected var _connections : Vector.<QuizConnectionVO>;
		
		protected var _lines : Sprite;
		
		protected var _currentConnectPoint : ButtonComponentView;
		protected var _textsModel : ITextsModel;
		protected var _randomAlternatives1 : Vector.<QuizAlternativeVO>;
		protected var _randomAlternatives2 : Vector.<QuizAlternativeVO>;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			_assets = assets;
			_connectVO = componentVO as ConnectQuizVO;
			_connections = new Vector.<QuizConnectionVO>();
			
			_lines = new Sprite();
			addChild(_lines);
			
			//Sets and Adds the first image background, if avaiable
			if (_connectVO.firstImageBackgroundImage != null)
			{
				_firstImageBackgroundImage = new GraphicComponentView();
				_firstImageBackgroundImage.Initialize(_connectVO.firstImageBackgroundImage, assets);
				addChild(_firstImageBackgroundImage);
			}
			
			//Sets and Adds the first text background, if avaiable
			if (_connectVO.firstTextBackgroundImage != null)
			{
				_firstTextBackgroundImage = new GraphicComponentView();
				_firstTextBackgroundImage.Initialize(_connectVO.firstTextBackgroundImage, assets);
				addChild(_firstTextBackgroundImage);
			}
			
			//Sets and Adds the second text background, if avaiable
			if (_connectVO.secondTextBackgroundImage != null)
			{
				_secondTextBackgroundImage = new GraphicComponentView();
				_secondTextBackgroundImage.Initialize(_connectVO.secondTextBackgroundImage, assets);
				addChild(_secondTextBackgroundImage);
			}
			
			var alternativeVO : ButtonComponentVO;
			var newAlternativeView : ButtonComponentView;
			
			//Sets and Adds the First Alternatives buttons
			_firstAlternatives = new Vector.<ButtonComponentView>();
			for each (alternativeVO in _connectVO.firstAlternatives) 
			{
				newAlternativeView = new ButtonComponentView();
				newAlternativeView.Initialize(alternativeVO, assets);
				newAlternativeView.addEventListener(MouseEvent.MOUSE_DOWN, HandleMouseDown);
				newAlternativeView.addEventListener(MouseEvent.MOUSE_UP, HandleMouseUp);
				newAlternativeView.addEventListener(MouseEvent.CLICK, HandleMouseClick);
				addChild(newAlternativeView);
				_firstAlternatives.push(newAlternativeView);
			}
			
			//Sets and Adds the Second Alternatives buttons
			_secondAlternatives = new Vector.<ButtonComponentView>();
			for each (alternativeVO in _connectVO.secondAlternatives) 
			{
				newAlternativeView = new ButtonComponentView();
				newAlternativeView.Initialize(alternativeVO, assets);
				newAlternativeView.addEventListener(MouseEvent.MOUSE_DOWN, HandleMouseDown);
				newAlternativeView.addEventListener(MouseEvent.MOUSE_UP, HandleMouseUp);
				newAlternativeView.addEventListener(MouseEvent.CLICK, HandleMouseClick);
				addChild(newAlternativeView);
				_secondAlternatives.push(newAlternativeView);
			}
			
			//Sets and Adds the First Connect Alternatives buttons
			_firstConnectAlternatives = new Vector.<ButtonComponentView>();
			for each (alternativeVO in _connectVO.firstConnectAlternativesText) 
			{
				newAlternativeView = new ButtonComponentView();
				newAlternativeView.Initialize(alternativeVO, assets);
				newAlternativeView.addEventListener(MouseEvent.MOUSE_DOWN, HandleMouseDown);
				newAlternativeView.addEventListener(MouseEvent.MOUSE_UP, HandleMouseUp);
				newAlternativeView.addEventListener(MouseEvent.CLICK, HandleMouseClick);
				addChild(newAlternativeView);
				_firstConnectAlternatives.push(newAlternativeView);
			}
			
			//Sets and Adds the Second Connect Alternatives buttons
			_secondConnectAlternatives = new Vector.<ButtonComponentView>();
			for each (alternativeVO in _connectVO.secondConnectAlternativesText) 
			{
				newAlternativeView = new ButtonComponentView();
				newAlternativeView.Initialize(alternativeVO, assets);
				newAlternativeView.addEventListener(MouseEvent.MOUSE_DOWN, HandleMouseDown);
				newAlternativeView.addEventListener(MouseEvent.MOUSE_UP, HandleMouseUp);
				newAlternativeView.addEventListener(MouseEvent.CLICK, HandleMouseClick);
				addChild(newAlternativeView);
				_secondConnectAlternatives.push(newAlternativeView);
			}
			
			super.Initialize(componentVO, assets);
			
			if (_points != null) addChild(_points);
			if (_confirm != null) addChild(_confirm);
		}

		private function HandleMouseUp(event : MouseEvent) : void 
		{
			if (!_connectVO.drag) return;
			event.stopImmediatePropagation();
			var target : ButtonComponentView = event.currentTarget as ButtonComponentView;
			var connection : ButtonComponentView = FindConnectPointFromClick(target);
			if (_currentConnectPoint != null)
			{
				if (IsOpposite(connection, _currentConnectPoint)) AddConnection(connection, _currentConnectPoint);
				Deselect();
			}
		}

		private function AddConnection(target1 : ButtonComponentView, target2 : ButtonComponentView) : void 
		{
			if (target1 == target2 || !IsOpposite(target1, target2)) return;
			var i : int;
			for (i = _connections.length - 1; i >= 0; i--) 
			{
				if (_connections[i].Contains(target1) || _connections[i].Contains(target2)) 
				{	
					_connections.splice(i, 1);	
				}
			}
			
			var newConnection : QuizConnectionVO = new QuizConnectionVO(target1, target2);
			_connections.push(newConnection);	
			
			for (i = 0; i < _firstConnectAlternatives.length; i++) {
					_firstConnectAlternatives[i].SetState(ButtonProperties.NORMAL_STATE);
					_secondConnectAlternatives[i].SetState(ButtonProperties.NORMAL_STATE);
					_textsModel.SetVariable(_connectVO.GetAlternativeConnectTextVarName(i, 1, true), "");
					_textsModel.SetVariable(_connectVO.GetAlternativeConnectTextVarName(i, 2, true), "");
			}
			
			for (i = 0; i < _connections.length; i++) 
			{
				_connections[i].target1.SetState(ButtonProperties.ACTIVE_STATE);
				_connections[i].target2.SetState(ButtonProperties.ACTIVE_STATE);
				_textsModel.SetVariable(_connectVO.GetAlternativeConnectTextVarName(GetConnectIndex(_connections[i].target1), _firstConnectAlternatives.indexOf(_connections[i].target1) != -1 ? 1 : 2, true), i + 1 + "");
				_textsModel.SetVariable(_connectVO.GetAlternativeConnectTextVarName(GetConnectIndex(_connections[i].target2), _firstConnectAlternatives.indexOf(_connections[i].target2) != -1 ? 1 : 2, true), i + 1 + "");					
			}
			
			if (_connections.length >= _connectVO.numOfAlternatives)
			{
				_confirm.SetState(ButtonProperties.NORMAL_STATE);
				addChild(_confirm);
				_confirm.mouseEnabled = true;
				_confirm.mouseChildren = true;
			}
			else
			{
				_confirm.SetState(ButtonProperties.DISABLED_STATE);
			}
			
			if (_connectVO.connectSound != null) PlaySoundOnce(_connectVO.connectSound, _connectVO.connectSoundLayer);
				
		}

		private function GetConnectIndex(target : ButtonComponentView) : int 
		{
			var i : int;
			for (i = 0; i < _firstConnectAlternatives.length; i++) 
			{
				if (_firstConnectAlternatives[i] == target) return i;
				if (_secondConnectAlternatives[i] == target) return i;
			}
			throw new Error("Incorrect connection, something went very very very wrong!");
		}

		private function IsOpposite(target : ButtonComponentView, currentConnectPoint : ButtonComponentView) : Boolean 
		{
			var found : Boolean = false;
			for each (var connection : ButtonComponentView in _firstConnectAlternatives) 
			{
				if (connection == target || connection == currentConnectPoint) 
				{
					if (found) return false;
					found = true;
				}
			}			
			return found;
		}
		
		private function HandleMouseClick(event : MouseEvent) : void 
		{
			if (_connectVO.drag) return;
			event.stopPropagation();
			event.stopImmediatePropagation();
			var clicked : ButtonComponentView = event.currentTarget as ButtonComponentView;
			
			if (_currentConnectPoint == null)
			{
				_currentConnectPoint = FindConnectPointFromClick(clicked);
				addEventListener(Event.ENTER_FRAME, UpdateLineMouseFollower);
				stage.addEventListener(MouseEvent.CLICK, Deselect);
			}
			else
			{
				var connection : ButtonComponentView = FindConnectPointFromClick(clicked);
				if (IsOpposite(connection, _currentConnectPoint)) AddConnection(connection, _currentConnectPoint);
				Deselect();
			}			
		}

		private function HandleMouseDown(event : MouseEvent) : void 
		{
			if (!_connectVO.drag) return;
			var clicked : ButtonComponentView = event.currentTarget as ButtonComponentView;
			
			_currentConnectPoint = FindConnectPointFromClick(clicked);
			addEventListener(Event.ENTER_FRAME, UpdateLineMouseFollower);
			stage.addEventListener(MouseEvent.MOUSE_UP, Deselect);
		}

		private function Deselect(event : MouseEvent = null) : void 
		{
			_currentConnectPoint = null;
			removeEventListener(Event.ENTER_FRAME, UpdateLineMouseFollower);	
			if (stage.hasEventListener(MouseEvent.CLICK)) stage.removeEventListener(MouseEvent.CLICK, Deselect);
			if (stage.hasEventListener(MouseEvent.MOUSE_UP)) stage.removeEventListener(MouseEvent.MOUSE_UP, Deselect);
			UpdateLines();	
		}

		private function UpdateLineMouseFollower(event : Event) : void 
		{
			UpdateLines();
		}

		private function UpdateLines() : void 
		{
			_lines.graphics.clear();
			_lines.graphics.lineStyle(2, 0xDDDDDD);
			if (_currentConnectPoint != null)
			{
				_lines.graphics.moveTo(_currentConnectPoint.x + (_currentConnectPoint.width/2), _currentConnectPoint.y + (_currentConnectPoint.height/2));
				_lines.graphics.lineTo(mouseX, mouseY);
			}
			
			for each (var connection : QuizConnectionVO in _connections) 
			{
				_lines.graphics.moveTo(connection.target1.x + (connection.target1.width/2), connection.target1.y + (connection.target1.height/2));
				_lines.graphics.lineTo(connection.target2.x + (connection.target2.width/2), connection.target2.y + (connection.target2.height/2));	
			}
		}

		private function FindConnectPointFromClick(clicked : ButtonComponentView) : ButtonComponentView 
		{
			var alternative : ButtonComponentView;
			for each (alternative in _firstAlternatives) 
			{
				if (alternative == clicked)
				{
					return _firstConnectAlternatives[_firstAlternatives.indexOf(alternative)];
				}
			}
			
			for each (alternative in _secondAlternatives) 
			{
				if (alternative == clicked)
				{
					return _secondConnectAlternatives[_secondAlternatives.indexOf(alternative)];
				}
			}
			return clicked;
		}
		
		override protected function OpenTip() : void 
		{
			super.OpenTip();		
		}

		override protected function CloseTip() : void 
		{
			super.CloseTip();
		}

		override protected function AnswerQuestion() : void 
		{
			if (_currentQuestion.answered) return;
			Disactivate();
			var order1 : Vector.<QuizAlternativeVO> = new Vector.<QuizAlternativeVO>();
			var order2 : Vector.<QuizAlternativeVO> = new Vector.<QuizAlternativeVO>();
			for each (var connect : QuizConnectionVO in _connections) {
				order1.push(GetAlternativeVO(connect.target1));
				order2.push(GetAlternativeVO(connect.target2));
			}
			
			var answer : QuizAnswerVO = new QuizAnswerVO(_currentQuestion, order1, order2);
			dispatchEvent(new MultiAlternativesEvent(MultiAlternativesEvent.ANSWER, answer));
		}	
		
		private function GetAlternativeVO(target : ButtonComponentView) : QuizAlternativeVO 
		{
			var i : int;
			for (i = 0; i < _firstConnectAlternatives.length; i++) 
			{
				if (_firstConnectAlternatives[i] == target)
					return _randomAlternatives1[i];
			}
			
			for (i = 0; i < _secondConnectAlternatives.length; i++) 
			{
				if (_secondConnectAlternatives[i] == target)
					return _randomAlternatives2[i];
			}
		}	
		
		override public function CheckQuizUpdate(event : QuizFeedEvent, textModel : ITextsModel) : void
		{
			if (event.targetName != _componentVO.name) return;
			
			_currentQuestion = event.question;
			textModel.SetVariable(_connectVO.GetPointsTextVarName(), _currentQuestion.score + "");
			textModel.SetVariable(_connectVO.GetTitleTextVarName(), _currentQuestion.text);
			textModel.SetVariable(_connectVO.GetTipTextVarName(), _currentQuestion.tip);
			
			var i : int;
			
			_randomAlternatives1 = MixAlternatives(_currentQuestion);
			if (event.question.type == QuizType.TEXT_ORDER) SetTextToTextQuestion(event, textModel);
			if (event.question.type == QuizType.IMAGE_ORDER) SetImageToTextQuestion(event, textModel);
			
			_randomAlternatives2 = MixAlternatives(_currentQuestion);
			for (i = 0; i < _currentQuestion.alternatives.length && i < _secondAlternatives.length; i++) 
			{
				_secondAlternatives[i].SetState(ButtonProperties.NORMAL_STATE);			
				textModel.SetVariable(_connectVO.GetAlternativeTextVarName(i, 2, true), _randomAlternatives2[i].text2);
			}
			
			for (i = 0; i < _firstConnectAlternatives.length; i++) {
					_firstConnectAlternatives[i].SetState(ButtonProperties.NORMAL_STATE);
					_secondConnectAlternatives[i].SetState(ButtonProperties.NORMAL_STATE);
					_textsModel.SetVariable(_connectVO.GetAlternativeConnectTextVarName(i, 1, true), "");
					_textsModel.SetVariable(_connectVO.GetAlternativeConnectTextVarName(i, 2, true), "");
			}
			
			_connections = new Vector.<QuizConnectionVO>();
			if (_confirm != null) _confirm.SetState(ButtonProperties.DISABLED_STATE);
			if (!_connectVO.CanGetTip() && _openTipButton != null) _openTipButton.SetState(ButtonProperties.DISABLED_STATE);
		}

		private function SetImageToTextQuestion(event : QuizFeedEvent, textModel : ITextsModel) : void 
		{
			if (_firstTextBackgroundImage != null && contains(_firstTextBackgroundImage)) removeChild(_firstTextBackgroundImage);
			if (_firstImageBackgroundImage != null) addChildAt(_firstImageBackgroundImage, 0);
			
			var i : int;	
			for (i = 0; i < _currentQuestion.alternatives.length && i < _firstAlternatives.length; i++) 
			{
				var oldIndex : int = getChildIndex(_firstAlternatives[i]);
				removeChild(_firstAlternatives[i]);
				_firstAlternatives[i] = new ButtonComponentView();
				_firstAlternatives[i].Initialize(_connectVO.GenerateImageButtonSpec(_randomAlternatives1[i].image, i, 1), _assets);
				_firstAlternatives[i].addEventListener(MouseEvent.MOUSE_DOWN, HandleMouseDown);
				_firstAlternatives[i].addEventListener(MouseEvent.MOUSE_UP, HandleMouseUp);
				_firstAlternatives[i].addEventListener(MouseEvent.CLICK, HandleMouseClick);
				addChildAt(_firstAlternatives[i], oldIndex);
				_firstAlternatives[i].SetState(ButtonProperties.NORMAL_STATE);				
				textModel.SetVariable(_connectVO.GetAlternativeTextVarName(i, 1, true), "");
			}
			
			for each (var c : ButtonComponentView in _firstConnectAlternatives) {
				c.x += _connectVO.firstImageConnectOffsetX;
				c.y += _connectVO.firstImageConnectOffsetY;
			}
		}

		private function SetTextToTextQuestion(event : QuizFeedEvent, textModel : ITextsModel) : void 
		{
			if (_firstImageBackgroundImage != null && contains(_firstImageBackgroundImage)) removeChild(_firstImageBackgroundImage);
			var i : int;	
			for (i = 0; i < _currentQuestion.alternatives.length && i < _firstAlternatives.length; i++) 
			{
				_firstAlternatives[i].SetState(ButtonProperties.NORMAL_STATE);	
				_firstConnectAlternatives[i].SetState(ButtonProperties.NORMAL_STATE);				
				textModel.SetVariable(_connectVO.GetAlternativeTextVarName(i, 1, true), _randomAlternatives1[i].text);
			}
		}
		
		public function RegisterTexts(textsModel : ITextsModel) : void
		{
			_textsModel = textsModel;
		}
	}
}
