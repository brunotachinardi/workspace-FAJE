package com.eguru.faje.mvcs.models.data.quiz {
	/**
	 * @author Bruno Tachinardi
	 */
	public class QuizQuestionVO 
	{
		protected var _id : int;
		protected var _text : String;
		protected var _image : String;
		protected var _sound : String;
		protected var _type : String;
		protected var _category : String;
		protected var _score : int;
		protected var _level : int;
		protected var _levelDefinition : String;
		protected var _tip : String;
		protected var _alternatives : Vector.<QuizAlternativeVO>;
		protected var _answer : QuizAnswerVO;
		
		public function QuizQuestionVO(specification : Object) 
		{
			_id = specification["idQuestion"];
			_text = specification["txtQuestion"];
			_image = specification["imgQuestion"];
			_sound = specification["soundQuestion"];
			_type = specification["typeQuestion"];
			_category = specification["categoryQuestion"];
			_score = specification["score"];
			_level = specification["level"];
			_levelDefinition = specification["levelDefinition"];
			_tip = specification["tip"];
			_alternatives = new Vector.<QuizAlternativeVO>();
			for each (var o : Object in specification["alternatives"]) 
			{
				_alternatives.push(new QuizAlternativeVO(o));
			}
		}
		
		public function get alternatives() : Vector.<QuizAlternativeVO>
		{
			return _alternatives;
		}
		
		public function get tip() : String
		{
			return _tip;
		}
		
		public function get levelDefinition() : String
		{
			return _levelDefinition;
		}
		
		public function get level() : int
		{
			return _level;
		}
		
		public function get score() : int
		{
			return _score;
		}
		
		public function get category() : String
		{
			return _category;
		}
		
		public function get type() : String
		{
			return _type;
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
		
		public function get id() : int
		{
			return _id;
		}
		
		public function get answered() : Boolean
		{
			return _answer != null;
		}
		
		public function get answer() : QuizAnswerVO
		{
			return _answer;
		}
		
		public function SetAnswer(answer : QuizAnswerVO) : void
		{
			_answer = answer;
		}
		
		public function Reset() : void
		{
			_answer = null;
		}
		
		public function GetAlternativesOrderByIds(ids : Array) : Vector.<QuizAlternativeVO>
		{
			if (ids == null) return null;
			var finalList : Vector.<QuizAlternativeVO> = new Vector.<QuizAlternativeVO>();
			for each (var id : String in ids) 
			{
				for each (var alternative : QuizAlternativeVO in _alternatives) 
				{
					if (alternative.id == id)
					{
						finalList.push(alternative);
						break;
					}
				}
			}
			return finalList;
		}
	}
}
