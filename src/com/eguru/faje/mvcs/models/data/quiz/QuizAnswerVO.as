package com.eguru.faje.mvcs.models.data.quiz {
	/**
	 * @author Bruno Tachinardi
	 */
	public class QuizAnswerVO 
	{
		protected var _question : QuizQuestionVO;
		protected var _alternativesOrder : Vector.<QuizAlternativeVO>;
		protected var _alternativesOrder2 : Vector.<QuizAlternativeVO>;

		public function QuizAnswerVO(question : QuizQuestionVO, alternativesOrder : Vector.<QuizAlternativeVO>, alternativesOrder2 : Vector.<QuizAlternativeVO> = null) 
		{
			_question = question;
			_question.SetAnswer(this);
			_alternativesOrder = alternativesOrder;
			_alternativesOrder2 = alternativesOrder2;
		}
		
		public function get question() : QuizQuestionVO
		{
			return _question;
		}
		
		public function get alternativesOrder() : Vector.<QuizAlternativeVO>
		{
			return _alternativesOrder;
		}
		
		public function get alternativesOrder2() : Vector.<QuizAlternativeVO>
		{
			return _alternativesOrder2;
		}
	}
}
