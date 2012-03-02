package com.eguru.faje.mvcs.views.components.quiz {
	import com.eguru.faje.mvcs.views.components.quiz.BaseQuizComponentViewMediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class MultiAlternativeQuizComponentViewMediator extends BaseQuizComponentViewMediator 
	{
		[Inject]
		public var multiview : MultiAlternativeQuizComponentView;
		
		override public function onRegister() : void
		{
			view = multiview;
			super.onRegister();
		}
		
	}
}
