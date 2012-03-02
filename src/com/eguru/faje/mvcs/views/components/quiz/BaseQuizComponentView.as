package com.eguru.faje.mvcs.views.components.quiz {
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.controllers.events.QuizFeedEvent;
	import com.eguru.faje.mvcs.models.data.quiz.QuizAlternativeVO;
	import flash.events.MouseEvent;
	import com.eguru.faje.mvcs.models.data.components.ButtonProperties;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.models.data.quiz.QuizQuestionVO;
	import com.eguru.faje.mvcs.views.components.ButtonComponentView;
	import com.eguru.faje.mvcs.views.components.TextBoxComponentView;
	import com.eguru.faje.mvcs.views.components.GraphicComponentView;
	import com.eguru.faje.mvcs.models.data.components.quiz.BaseQuizComponentVO;
	import com.eguru.faje.mvcs.views.components.core.ComponentView;

	/**
	 * @author Bruno Tachinardi
	 */
	public class BaseQuizComponentView extends ComponentView 
	{
		protected var _quizVO : BaseQuizComponentVO;
		protected var _background : GraphicComponentView;
		protected var _title : TextBoxComponentView;
		protected var _points : TextBoxComponentView;
		protected var _confirm : ButtonComponentView;
		protected var _tipBox : TextBoxComponentView;
		protected var _openTipButton : ButtonComponentView;
		protected var _closeTipButton : ButtonComponentView;
		protected var _currentQuestion : QuizQuestionVO;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			_quizVO = componentVO as BaseQuizComponentVO;
			//Sets and Adds the Background, if avaiable
			if (_quizVO.background != null)
			{
				_background = new GraphicComponentView();
				_background.Initialize(_quizVO.background, assets);
				addChild(_background);
			}
			
			//Sets and Adds the Points Box, if avaiable
			if (_quizVO.pointsBox != null)
			{
				_points = new TextBoxComponentView();
				_points.Initialize(_quizVO.pointsBox, assets);
				addChild(_points);
			}
			
			//Sets and Adds the Confirm Button, if avaiable
			if (_quizVO.confirmButton != null)
			{
				_confirm = new ButtonComponentView();
				_confirm.Initialize(_quizVO.confirmButton, assets);
				addChild(_confirm);
				_confirm.SetState(ButtonProperties.DISABLED_STATE);
				_confirm.addEventListener(MouseEvent.CLICK, HandleConfirmClick);
			}
			
			
			
			//Sets and Adds the Open Tip Button, if avaiable
			if (_quizVO.openTipButton != null)
			{
				_openTipButton = new ButtonComponentView();
				_openTipButton.Initialize(_quizVO.openTipButton, assets);
				_openTipButton.addEventListener(MouseEvent.CLICK, HandleOpenTip);
				_openTipButton.SetState(ButtonProperties.DISABLED_STATE);
				addChild(_openTipButton);
				if (_quizVO.CanGetTip()) _openTipButton.SetState(ButtonProperties.NORMAL_STATE);
			}
						
			
			//Sets and Adds the Title Box
			_title = new TextBoxComponentView();
			_title.Initialize(_quizVO.title, assets);
			addChild(_title);
			
			//Sets the Tip Box, if avaiable
			if (_quizVO.tipBox != null)
			{
				_tipBox = new TextBoxComponentView();
				_tipBox.Initialize(_quizVO.tipBox, assets);
				_tipBox.visible = false;
				addChild(_tipBox);
			}
			
			//Sets the Close Tip Button, if avaiable
			if (_quizVO.closeTipButton != null)
			{
				_closeTipButton = new ButtonComponentView();
				_closeTipButton.Initialize(_quizVO.closeTipButton, assets);
				_closeTipButton.addEventListener(MouseEvent.CLICK, HandleCloseTip);
				_closeTipButton.visible = false;
				addChild(_closeTipButton);
			}
			
			super.Initialize(componentVO, assets);
		}
		
		protected function HandleCloseTip(event : MouseEvent) : void 
		{
			CloseTip();
		}
		
		protected function HandleOpenTip(event : MouseEvent) : void 
		{
			OpenTip();
		}
		
		protected function OpenTip() : void 
		{
			if (!_quizVO.CanGetTip()) 
			{
				_openTipButton.SetState(ButtonProperties.DISABLED_STATE);
				return;
			}
			
			if (_confirm != null) _confirm.SetState(ButtonProperties.DISABLED_STATE);
			_openTipButton.visible = false;
			_tipBox.visible = true;
			addChild(_tipBox);
			_closeTipButton.visible = true;
			addChild(_closeTipButton);
			_quizVO.GetTip();
		}	

		protected function CloseTip() : void 
		{
			_openTipButton.visible = true;
			if (!_quizVO.CanGetTip()) _openTipButton.SetState(ButtonProperties.DISABLED_STATE);
			_tipBox.visible = false;
			_closeTipButton.visible = false;
		}
		
		private function HandleConfirmClick(event : MouseEvent) : void 
		{
			AnswerQuestion();
			_confirm.SetState(ButtonProperties.NORMAL_STATE);
			_confirm.removeEventListener(MouseEvent.CLICK, HandleConfirmClick);
		}
		
		protected function AnswerQuestion() : void 
		{
			throw new Error("This function must be overriden");
		}
		
		protected function MixAlternatives(question : QuizQuestionVO) : Vector.<QuizAlternativeVO>
		{
			var newOrder : Vector.<QuizAlternativeVO> = new Vector.<QuizAlternativeVO>();
			var oldOrder : Vector.<QuizAlternativeVO> = new Vector.<QuizAlternativeVO>();
			
			for each (var alternative : QuizAlternativeVO in question.alternatives) 
			{
				oldOrder.push(alternative);
			}
			
			while (oldOrder.length > 0)
			{
				var randomIndex : int = Math.floor(Math.random() * oldOrder.length);
				newOrder.push(oldOrder.splice(randomIndex, 1)[0]);
			}
			return newOrder;
		}
		
		override public function ApplyProperties() : void
		{
			_componentVO.displayProperties.InvalidateSizeModifiers();
			super.ApplyProperties();
			_componentVO.displayProperties.RevalidateSizeModifiers();
		}
		
		public function get quizVO() : BaseQuizComponentVO
		{
			return _quizVO;
		}
		
		public function CheckQuizUpdate(event : QuizFeedEvent, textModel : ITextsModel) : void
		{
			throw new Error("This function must be overriden");
		}
	}
}
