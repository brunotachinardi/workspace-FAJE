package com.eguru.faje.mvcs.controllers.bootstraps {
	import com.eguru.faje.mvcs.controllers.commands.SetGameConfigCommand;
	import com.eguru.faje.mvcs.controllers.events.RequestLoadAssetEvent;
	import com.eguru.faje.mvcs.controllers.commands.LoadGameComponentsCommand;
	import com.eguru.faje.mvcs.controllers.events.FixedStateChangeEvent;
	import com.eguru.faje.mvcs.controllers.commands.ResumeComponentsActivationCommand;
	import com.eguru.faje.mvcs.controllers.events.LoadAssetsServiceEvent;
	import com.eguru.faje.mvcs.controllers.events.ComponentModelEvent;
	import com.eguru.faje.mvcs.controllers.commands.SetPreloaderComponentsCommand;
	import com.eguru.faje.mvcs.controllers.commands.LoadMissingComponentsAssetsCommand;
	import com.eguru.faje.mvcs.controllers.events.PreloaderConfigLoadingServiceEvent;
	import com.eguru.faje.mvcs.controllers.commands.LoadPreloaderConfigCommand;
	import org.robotlegs.base.ContextEvent;
	import org.robotlegs.core.ICommandMap;
	/**
	 * @author Bruno Tachinardi
	 */
	public class BootstrapCommands extends Object 
	{
		public function BootstrapCommands(commandMap:ICommandMap)
        {
			//Startup
			commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, LoadPreloaderConfigCommand, ContextEvent, true);
			
			commandMap.mapEvent(PreloaderConfigLoadingServiceEvent.LOAD_COMPLETED, SetPreloaderComponentsCommand, PreloaderConfigLoadingServiceEvent, true);
			commandMap.mapEvent(ComponentModelEvent.MISSING_ASSETS, LoadMissingComponentsAssetsCommand, ComponentModelEvent, true);
			commandMap.mapEvent(RequestLoadAssetEvent.LOAD_ALL_ASSETS, LoadMissingComponentsAssetsCommand, RequestLoadAssetEvent, true);
			commandMap.mapEvent(LoadAssetsServiceEvent.LOAD_COMPLETED, ResumeComponentsActivationCommand, LoadAssetsServiceEvent, true);
			commandMap.mapEvent(FixedStateChangeEvent.PRELOADER_STATE, LoadGameComponentsCommand, FixedStateChangeEvent, true);
			commandMap.mapEvent(FixedStateChangeEvent.GAME_CONFIG_STATE, SetGameConfigCommand, FixedStateChangeEvent, true);
        }
	}
}
