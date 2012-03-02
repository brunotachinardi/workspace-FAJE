package com.eguru.faje.mvcs.models.data.quiz {
	/**
	 * @author Bruno Tachinardi
	 */
	public class QuizAlternativeVO 
	{
		protected var _id : int;
		protected var _text : String;
		protected var _text_2 : String;
		protected var _image : String;
		protected var _sound : String;
		protected var _feedback : QuizFeedbackVO;
		protected var _correct : Number;
		protected var _order : int;
		
		public function QuizAlternativeVO(specification : Object) 
		{
			_id = specification["idAlternative"];
			_text = specification["txtAlternative01"];
			_text_2 = specification["txtAlternative02"];
			_image = specification["imgAlternative"];
			_sound = specification["soundAlternative"];
			_feedback = new QuizFeedbackVO(specification["feedback"]);
			_correct = specification["correct"];
			_order = specification["order"];			
		}
		
		public function get order() : int
		{
			return _order;
		}
		
		public function get correct() : Number
		{
			return _correct;
		}
		
		public function get feedback() : QuizFeedbackVO
		{
			return _feedback;
		}
		
		public function get sound() : String
		{
			return _sound;
		}
		
		public function get image() : String
		{
			return _image;
		}
		
		public function get text() : String
		{
			return _text;
		}
		
		public function get text2() : String
		{
			return _text_2;
		}
		
		public function get id() : int
		{
			return _id;
		}
	}
}
