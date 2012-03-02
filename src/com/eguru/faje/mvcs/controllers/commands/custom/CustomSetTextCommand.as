package com.eguru.faje.mvcs.controllers.commands.custom {
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomCommand;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomSetTextCommand extends CustomCommand {
		
		[Inject]
		public var textsModel : ITextsModel;
		
		override public function execute() : void
		{
			super.execute();
			var variable : String = _spec["variable"];
			var value : String = _spec["value"];
			textsModel.SetVariable(variable , value);
		}
	}
}
