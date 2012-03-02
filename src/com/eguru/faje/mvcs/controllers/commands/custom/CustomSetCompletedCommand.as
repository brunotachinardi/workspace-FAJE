package com.eguru.faje.mvcs.controllers.commands.custom {
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.services.ISCORMService;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomCommand;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomSetCompletedCommand extends CustomCommand {
		
		[Inject]
		public var scormService : ISCORMService;
		
		[Inject]
		public var varModel : IAppNumberVariableModel;
		
		override public function execute() : void
		{
			super.execute();
			scormService.SetCompleted(varModel);
		}
	}
}
