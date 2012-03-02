package com.eguru.faje.mvcs.views.components.quiz {
	
	import com.eguru.faje.mvcs.views.components.events.MultiAlternativesEvent;
	import com.eguru.faje.mvcs.models.IQuizModel;
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.controllers.events.QuizFeedEvent;
	import org.robotlegs.mvcs.Mediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class BaseQuizComponentViewMediator extends Mediator 
	{
		public var view : BaseQuizComponentView;
		
		[Inject]
		public var textModel : ITextsModel;
		
		[Inject]
		public var quizModel : IQuizModel;
		
		override public function onRegister() : void
		{
			addContextListener(QuizFeedEvent.FEED, UpdateQuiz, QuizFeedEvent);
			view.addEventListener(MultiAlternativesEvent.ANSWER, HandleAnswer);
		}

		private function HandleAnswer(event : MultiAlternativesEvent) : void 
		{
			if (view.exiting) return;
			quizModel.AnswerQuestion(event.answer);
		}
		
		protected function UpdateQuiz(event : QuizFeedEvent) : void 
		{	
			if (view.exiting) return;		
			view.CheckQuizUpdate(event, textModel);
		}
	}
}
