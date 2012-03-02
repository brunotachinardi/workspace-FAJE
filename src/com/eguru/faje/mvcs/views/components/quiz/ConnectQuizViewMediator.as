package com.eguru.faje.mvcs.views.components.quiz {
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.views.components.quiz.BaseQuizComponentViewMediator;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ConnectQuizViewMediator extends BaseQuizComponentViewMediator {
		
		[Inject]
		public var connectview : ConnectQuizView;
		
		[Inject]
		public var textsModel : ITextsModel;
		
		override public function onRegister() : void
		{
			view = connectview;
			connectview.RegisterTexts(textsModel);
			super.onRegister();
		}
	}
}
