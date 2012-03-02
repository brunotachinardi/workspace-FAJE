package com.eguru.faje.mvcs.controllers.commands.custom {
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomCommand;

	/**
	 * @author Bruno Tachinardi
	 */
	public class CustomSetVariableCommand extends CustomCommand {
		
		[Inject]
		public var varsModel : IAppNumberVariableModel;
		
		override public function execute() : void
		{
			super.execute();
			var name : String = _spec["name"];
			var value : Number = _spec["value"];
			varsModel.SetVariable(name, value);
		}
	}
}
