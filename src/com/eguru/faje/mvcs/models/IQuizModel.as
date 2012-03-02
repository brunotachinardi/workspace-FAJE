package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.models.data.quiz.QuizAnswerVO;
	import com.eguru.faje.mvcs.models.data.quiz.QuizQuestionVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IQuizModel 
	{
		function AnswerQuestion(answer : QuizAnswerVO) : void;
		function GetRandomQuestion(type : String, category : String = null, maxLevel : int = 999) : QuizQuestionVO;
		function GetQuestionById(id : int) : QuizQuestionVO;
		function AddRawQuestions(specification : Object) : void;
		function Reset() : void;
	}
}
