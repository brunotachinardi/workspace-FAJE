package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.services.ISCORMService;
	import com.eguru.faje.mvcs.controllers.events.StateMachineEvent;
	import com.eguru.faje.mvcs.models.data.quiz.QuizType;
	import com.eguru.faje.mvcs.models.data.quiz.QuizVO;
	import org.robotlegs.mvcs.Actor;

	import com.eguru.faje.mvcs.models.IQuizModel;
	import com.eguru.faje.mvcs.models.data.quiz.QuizQuestionVO;
	import com.eguru.faje.mvcs.models.data.quiz.QuizAnswerVO;
	import com.eguru.faje.mvcs.models.data.quiz.QuizFeedbackVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class QuizModel extends Actor implements IQuizModel {
		
		[Inject]
		public var variablesModel : IAppNumberVariableModel;
		
		[Inject]
		public var scormService : ISCORMService;
		
		protected var _quizzes : Vector.<QuizVO>;
		protected var _answeredQuestions : Vector.<QuizQuestionVO>;
		protected var _answers : Vector.<QuizAnswerVO>;
		protected var _currentQuestion : QuizQuestionVO;
		
		public function QuizModel() 
		{
			_quizzes = new Vector.<QuizVO>();
			_answeredQuestions = new Vector.<QuizQuestionVO>();
			_answers = new Vector.<QuizAnswerVO>();
			_currentQuestion = null;
		}

		public function AnswerQuestion(answer : QuizAnswerVO) : void 
		{
			_answeredQuestions.push(answer.question);
			_answers.push(answer);
			
			var feedback : QuizFeedbackVO;
			
			switch(answer.question.type){
				case QuizType.MULTI_CHOICES:
					feedback = AnswerMultiChoicesQuestion(answer);
					break;
				case QuizType.TEXT_ORDER:
					feedback = AnswerOrderQuestion(answer);
					break;
				case QuizType.IMAGE_ORDER:
					feedback = AnswerOrderQuestion(answer);
					break;
				default:
				throw new Error("Unimplemented quiz type: " + answer.question.type);
			}
			variablesModel.AddToVariable("QuestionsAnswered", 1);
			variablesModel.AddToVariable("QuestionsAnsweredThisState", 1);
			_currentQuestion = null;
			scormService.SaveCurrentQuestion(_currentQuestion);
			scormService.SaveAnswers(_answers);
			dispatch(new StateMachineEvent(StateMachineEvent.QUIZ_ANSWERED_MESSAGE));
		}

		private function AnswerOrderQuestion(answer : QuizAnswerVO) : QuizFeedbackVO 
		{
			var correct : Boolean = true;
			for (var i : int = 0; i < answer.alternativesOrder.length; i++) 
			{
				if (answer.alternativesOrder[i] != answer.alternativesOrder2[i])
				{
					correct = false;
				}
			}
			if (correct)
			{
				variablesModel.AddToVariable("Points", answer.question.score);
			}
			return answer.alternativesOrder[0].feedback;
		}

		private function AnswerMultiChoicesQuestion(answer : QuizAnswerVO) : QuizFeedbackVO 
		{
			variablesModel.AddToVariable("Points", answer.alternativesOrder[0].correct * answer.question.score);
			trace("Question Answered: " + answer.alternativesOrder[0].feedback.text + " Question correctness: " + answer.alternativesOrder[0].correct + " Question Score: " + answer.question.score);
			return answer.alternativesOrder[0].feedback;
		}

		public function GetRandomQuestion(type : String, category : String = null, maxLevel : int = 999) : QuizQuestionVO 
		{
			if (_currentQuestion != null) {
				if (_currentQuestion.type == type &&
				   (category == null || category == "" || _currentQuestion.category == category) &&
				   (isNaN(maxLevel) || _currentQuestion.level <= maxLevel))
				return _currentQuestion;
			}
			var questionsList : Vector.<QuizQuestionVO> = FilterQuestions(type, category, scormService.LoadStudentLevel());
			var randomIndex : int = Math.floor(Math.random() * questionsList.length);
			_currentQuestion = questionsList[randomIndex];
			scormService.SaveCurrentQuestion(_currentQuestion);			
			return _currentQuestion;
		}

		private function FilterQuestions(type : String, category : String, maxLevel : int) : Vector.<QuizQuestionVO> {
			var list : Vector.<QuizQuestionVO> = new Vector.<QuizQuestionVO>();
			
			for each (var quiz : QuizVO in _quizzes) 
			{
				for each (var question : QuizQuestionVO in quiz.questions) 
				{
					if (type != null && type != "" && question.type != type) continue;
					if (category != null && category != "" && question.category != category) continue;
					if (!isNaN(maxLevel) && question.level > maxLevel) continue;
					if (_answeredQuestions.indexOf(question) != -1) continue;
					if (question.answered) continue;
					
					list.push(question);
				}
			}	
			if (list.length == 0) {
				for each (var question : QuizQuestionVO in _answeredQuestions) {
					question.Reset();
				}
				_answeredQuestions = new Vector.<QuizQuestionVO>();		
				return FilterQuestions(type, category, maxLevel);
			}
			return list;
		}

		public function GetQuestionById(id : int) : QuizQuestionVO 
		{
			for each (var quiz : QuizVO in _quizzes) 
			{
				for each (var question : QuizQuestionVO in quiz.questions) 
				{
					if (question.id == id) return question;
				}
			}
			return null;
		}

		public function AddRawQuestions(specification : Object) : void 
		{
			_quizzes.push(new QuizVO(specification));
			scormService.LoadAnswers(this);
			_currentQuestion = scormService.LoadCurrentQuestion(this);
		}

		public function Reset() : void 
		{
			variablesModel.SetVariable("Points", 0);
			variablesModel.SetVariable("QuestionsAnswered", 0);
			variablesModel.AddToVariable("QuestionsAnsweredThisState", 0);
			_answers = new Vector.<QuizAnswerVO>();
			_answeredQuestions = new Vector.<QuizQuestionVO>();
			
			for each (var quiz : QuizVO in _quizzes) {
				for each (var question : QuizQuestionVO in quiz.questions) {
					question.Reset();
				}
			}
		}
	}
}
