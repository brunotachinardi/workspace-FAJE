package com.eguru.faje.mvcs.models.data.components.quiz.utils {
	import com.eguru.faje.mvcs.views.components.ButtonComponentView;
	/**
	 * @author Bruno Tachinardi
	 */
	public class QuizConnectionVO 
	{
		protected var _target1 : ButtonComponentView;
		protected var _target2 : ButtonComponentView;

		public function QuizConnectionVO(target1 : ButtonComponentView, target2 : ButtonComponentView) 
		{
			_target1 = target1;
			_target2 = target2;
		}
		
		public function get target1() : ButtonComponentView
		{
			return _target1;
		}
		
		public function get target2() : ButtonComponentView
		{
			return _target2;
		}
		
		public function Contains(other : ButtonComponentView) : Boolean
		{
			return (other == _target1 || other == _target2);
		}
	}
}
