package com.eguru.faje.mvcs.controllers.commands {
	import com.eguru.faje.mvcs.models.IConfigModel;
	import com.eguru.faje.mvcs.services.config.IPreloaderConfigLoadingService;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Bruno Tachinardi
	 */
	public class LoadPreloaderConfigCommand extends Command
	{
		[Inject]
		public var preloaderLoadService : IPreloaderConfigLoadingService;
		
		[Inject]
		public var configModel : IConfigModel;
		
		override public function execute():void
        {
            preloaderLoadService.LoadPreloaderConfig(configModel.preloaderConfigPath);            
        }
	}
}
