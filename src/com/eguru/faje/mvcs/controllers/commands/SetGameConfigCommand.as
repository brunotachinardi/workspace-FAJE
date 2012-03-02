package com.eguru.faje.mvcs.controllers.commands {
	import com.eguru.faje.mvcs.models.IConfigModel;
	import com.eguru.faje.mvcs.models.IComponentModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.controllers.events.StateMachineEvent;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Bruno Tachinardi
	 */
	public class SetGameConfigCommand extends Command 
	{
		[Inject]
		public var componentModel : IComponentModel;
		
		[Inject]
		public var configModel : IConfigModel;

		
		override public function execute() : void
		{
			trace("Game Configurations Successfully Set");
			var components : Vector.<ComponentVO> = configModel.preloaderConfig.components;
			componentModel.ActivateComponents(new Vector.<ComponentVO>(), components);
			dispatch(new StateMachineEvent(StateMachineEvent.STATE_MACHINE_READY_MESSAGE));
		}
	}
}
