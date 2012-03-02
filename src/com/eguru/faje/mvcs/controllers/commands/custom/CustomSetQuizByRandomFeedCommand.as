package com.eguru.faje.mvcs.controllers.commands.custom {
	import com.eguru.faje.mvcs.controllers.events.QuizFeedEvent;
	import com.eguru.faje.mvcs.models.data.quiz.QuizQuestionVO;
	import com.eguru.faje.mvcs.models.IQuizModel;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomCommand;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomSetQuizByRandomFeedCommand extends CustomCommand {
		
		[Inject]
		public var quizModel : IQuizModel;
		
		override public function execute() : void
		{
			super.execute();
			var type : String = (_spec.hasOwnProperty("type")) ? _spec["type"] : null;
			var category : String = (_spec.hasOwnProperty("category")) ? _spec["category"] : null;
			var maxLevel : int =(_spec.hasOwnProperty("maxLevel")) ? _spec["maxLevel"] : 999;
			var question : QuizQuestionVO = quizModel.GetRandomQuestion(type, category, maxLevel);
			var targetName : String = _spec["target"];
			dispatch(new QuizFeedEvent(QuizFeedEvent.FEED, targetName, question));
		}
	}
}
