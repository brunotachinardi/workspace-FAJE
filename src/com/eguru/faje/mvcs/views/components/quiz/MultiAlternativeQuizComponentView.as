package com.eguru.faje.mvcs.views.components.quiz 
{
	import com.eguru.faje.mvcs.views.components.ButtonComponentView;
	import com.eguru.faje.mvcs.views.components.quiz.BaseQuizComponentView;
	import com.eguru.faje.mvcs.models.data.quiz.QuizAlternativeVO;
	import com.eguru.faje.mvcs.models.data.quiz.QuizAnswerVO;
	import com.eguru.faje.mvcs.views.components.events.MultiAlternativesEvent;
	import com.eguru.faje.mvcs.models.data.components.ButtonProperties;
	import flash.events.MouseEvent;
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.controllers.events.QuizFeedEvent;
	import com.eguru.faje.mvcs.models.data.components.ButtonComponentVO;
	import com.eguru.faje.mvcs.models.data.components.quiz.MultiAlternativeQuizComponentVO;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class MultiAlternativeQuizComponentView extends BaseQuizComponentView 
	{
		protected var _multiAlternativeVO : MultiAlternativeQuizComponentVO;
		protected var _alternatives : Vector.<ButtonComponentView>;
		protected var _currentSelection : ButtonComponentView;
		private var _randomAlternatives : Vector.<QuizAlternativeVO>;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			super.Initialize(componentVO, assets);
			
			_multiAlternativeVO = componentVO as MultiAlternativeQuizComponentVO;
			
			//Sets and Adds the Alternatives buttons
			_alternatives = new Vector.<ButtonComponentView>();
			for each (var alternativeVO : ButtonComponentVO in _multiAlternativeVO.alternatives) 
			{
				var newAlternativeView : ButtonComponentView = new ButtonComponentView();
				newAlternativeView.Initialize(alternativeVO, assets);
				newAlternativeView.addEventListener(MouseEvent.CLICK, HandleAlternativeClick);
				addChild(newAlternativeView);
				_alternatives.push(newAlternativeView);
			}
		}
		
		override protected function OpenTip() : void 
		{
			super.OpenTip();
			for each (var alternative : ButtonComponentView in _alternatives) 
			{
				alternative.SetState(ButtonProperties.DISABLED_STATE);
			}			
		}

		override protected function CloseTip() : void 
		{
			super.CloseTip();
			for each (var alternative : ButtonComponentView in _alternatives) 
			{
				if (_currentSelection == alternative) alternative.SetState(ButtonProperties.ACTIVE_STATE);
				else alternative.SetState(ButtonProperties.NORMAL_STATE);				
			}
			if (_confirm != null) 
			{
				if (_currentSelection != null) _confirm.SetState(ButtonProperties.NORMAL_STATE);
			}
		}

		private function HandleAlternativeClick(event : MouseEvent) : void 
		{
			if (event.currentTarget is ButtonComponentView  && event.currentTarget != _currentSelection)
			{
				var alternativeBt : ButtonComponentView = event.currentTarget as ButtonComponentView;
				alternativeBt.SetState(ButtonProperties.ACTIVE_STATE);
				if (_currentSelection != null)
				{
					_currentSelection.SetState(ButtonProperties.NORMAL_STATE);
				}
				else
				{
					if (_confirm != null)
					{
						_confirm.SetState(ButtonProperties.NORMAL_STATE);						
					}
					else
					{
						AnswerQuestion();
					}
				}
				_currentSelection = alternativeBt;
				addChild(_currentSelection);
			}
		}

		override protected function AnswerQuestion() : void 
		{
			if (_currentQuestion.answered) return;
			Disactivate();
			var order : Vector.<QuizAlternativeVO> = new Vector.<QuizAlternativeVO>();
			order.push(GetAlternativeVO(_currentSelection));
			
			var answer : QuizAnswerVO = new QuizAnswerVO(_currentQuestion, order);
			dispatchEvent(new MultiAlternativesEvent(MultiAlternativesEvent.ANSWER, answer));
		}

		private function GetAlternativeVO(currentSelection : ButtonComponentView) : QuizAlternativeVO 
		{
			for (var i : int = 0; i < _alternatives.length; i++) 
			{
				if (_alternatives[i] == currentSelection)
					return _randomAlternatives[i];
			}
		}
		
		
		override public function CheckQuizUpdate(event : QuizFeedEvent, textModel : ITextsModel) : void
		{
			if (event.targetName != _componentVO.name) return;
			_currentQuestion = event.question;
			textModel.SetVariable(_multiAlternativeVO.GetPointsTextVarName(), _currentQuestion.score + "");
			textModel.SetVariable(_multiAlternativeVO.GetTitleTextVarName(), _currentQuestion.text);
			textModel.SetVariable(_multiAlternativeVO.GetTipTextVarName(), _currentQuestion.tip);
			
			_randomAlternatives = MixAlternatives(_currentQuestion);
			for (var i : int = 0; i < _currentQuestion.alternatives.length && i < _alternatives.length; i++) 
			{
				_alternatives[i].SetState(ButtonProperties.NORMAL_STATE);				
				textModel.SetVariable(_multiAlternativeVO.GetAlternativeTextVarName(i), _randomAlternatives[i].text);
			}
			_currentSelection = null;
			if (_confirm != null) _confirm.SetState(ButtonProperties.DISABLED_STATE);
			if (!_multiAlternativeVO.CanGetTip()) _openTipButton.SetState(ButtonProperties.DISABLED_STATE);
		}
		
		public function get multiAlternativeVO() : MultiAlternativeQuizComponentVO
		{
			return _multiAlternativeVO;
		}
	}
}
