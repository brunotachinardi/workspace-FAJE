package com.eguru.faje.mvcs.controllers.commands.custom {
	import com.eguru.faje.mvcs.models.IQuizModel;
	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomResetQuizCommand extends CustomCommand
	{
		[Inject]
		public var quizModel : IQuizModel;
		
		override public function execute() : void
		{
			super.execute();
			quizModel.Reset();
		}
	}
}
