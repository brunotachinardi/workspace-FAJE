package com.eguru.faje.mvcs.controllers.commands {
	import com.eguru.faje.mvcs.models.IComponentModel;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ResumeComponentsActivationCommand extends Command 
	{
		[Inject]
		public var componentModel : IComponentModel;
		
		override public function execute() : void
		{
			componentModel.ResumeActivation();
		}
	}
}
