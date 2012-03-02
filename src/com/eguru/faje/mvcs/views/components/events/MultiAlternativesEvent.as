package com.eguru.faje.mvcs.views.components.events 
{
	import com.eguru.faje.mvcs.models.data.quiz.QuizAnswerVO;
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class MultiAlternativesEvent extends Event 
	{
		
		public static const ANSWER : String = "MultiAlternativesEvent.Answer";
		
		private var _answer : QuizAnswerVO;
		
		public function MultiAlternativesEvent(type : String, answer : QuizAnswerVO) 
		{
			super(type);
			_answer = answer;
		}
		
		public function get answer() : QuizAnswerVO
		{
			return _answer;
		}
	}
}
