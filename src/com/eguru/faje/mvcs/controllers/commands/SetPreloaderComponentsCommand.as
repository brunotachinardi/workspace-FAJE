package com.eguru.faje.mvcs.controllers.commands {
	import com.eguru.faje.mvcs.services.ISCORMService;
	import com.eguru.faje.mvcs.models.IConfigModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.models.IComponentModel;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Bruno Tachinardi
	 */
	public class SetPreloaderComponentsCommand extends Command 
	{
		
		[Inject]
		public var componentModel : IComponentModel;
		
		[Inject]
		public var configModel : IConfigModel;
		
		[Inject]
		public var scormService : ISCORMService;
		
		override public function execute() : void
		{
			scormService.LoadScorm();
			var components : Vector.<ComponentVO> = configModel.preloaderConfig.components;
			componentModel.ActivateComponents(components, new Vector.<ComponentVO>());
			
		}
	}
}
