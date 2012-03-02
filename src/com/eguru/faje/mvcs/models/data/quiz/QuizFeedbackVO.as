package com.eguru.faje.mvcs.models.data.quiz {
	/**
	 * @author Bruno Tachinardi
	 */
	public class QuizFeedbackVO 
	{
		protected var _text : String;
		protected var _action : String;
		
		public function QuizFeedbackVO(specification : Object) 
		{
			_text = specification["txt"];
			_action = specification["action"];	
		}
		
		public function get text() : String
		{
			return _text;
		}
		
		public function get action() : String
		{
			return _action;
		}
	}
}
