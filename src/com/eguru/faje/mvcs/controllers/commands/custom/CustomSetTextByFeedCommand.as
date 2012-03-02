package com.eguru.faje.mvcs.controllers.commands.custom {
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomCommand;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomSetTextByFeedCommand extends CustomCommand {
		
		[Inject]
		public var textsModel : ITextsModel;
		
		override public function execute() : void
		{
			super.execute();
			var variable : String = _spec["variable"];
			var feed : String = _spec["feed"];
			textsModel.SetVariableByFeed(variable , feed);
		}
	}
}
