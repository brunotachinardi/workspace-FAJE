package com.eguru.faje.mvcs.models.data.quiz {
	/**
	 * @author Bruno Tachinardi
	 */
	public class QuizVO 
	{
		protected var _version : QuizVersionVO;
		protected var _questions : Vector.<QuizQuestionVO>;
		
		public function QuizVO(specification : Object) 
		{
			_version = new QuizVersionVO(specification["version"]);
			_questions = new Vector.<QuizQuestionVO>();
			for each (var o : Object in specification["questions"])
			{
				_questions.push(new QuizQuestionVO(o));
			}
		}
		
		public function get version() : QuizVersionVO
		{
			return _version;
		}
		
		public function get questions() : Vector.<QuizQuestionVO>
		{
			return _questions;
		}
	}
}
