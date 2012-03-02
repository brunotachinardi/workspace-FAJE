package com.eguru.faje.mvcs.controllers.commands.custom {
	import com.eguru.faje.mvcs.services.ISCORMService;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomCommand;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomSetFailedCommand extends CustomCommand 
	{
		[Inject]
		public var scormService : ISCORMService;
		
		override public function execute() : void
		{
			super.execute();
			scormService.SetFailed();
		}
	}
}
