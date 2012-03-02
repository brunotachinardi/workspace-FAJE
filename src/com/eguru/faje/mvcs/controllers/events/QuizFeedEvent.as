package com.eguru.faje.mvcs.controllers.events 
{
	import com.eguru.faje.mvcs.models.data.quiz.QuizQuestionVO;
	import flash.events.Event;

	/**
	 * @author Bruno Tachinardi
	 */
	public class QuizFeedEvent extends Event 
	{
		
		public static const FEED : String = "QuizFeedEvent.feed";
		
		protected var _targetName : String;
		protected var _question  : QuizQuestionVO;

        public function QuizFeedEvent(type:String, targetName : String, question : QuizQuestionVO)
        {
            super(type);
			_question = question;
			_targetName = targetName;
        }

        override public function clone():Event
        {
            return new QuizFeedEvent(type, _targetName, _question);
        }
		
		public function get question() : QuizQuestionVO
		{
			return _question;
		}
		
		public function get targetName() : String
		{
			return _targetName;
		}
	}
}
