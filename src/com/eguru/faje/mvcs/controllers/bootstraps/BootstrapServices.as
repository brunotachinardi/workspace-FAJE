package com.eguru.faje.mvcs.controllers.bootstraps {
	import com.eguru.faje.mvcs.services.SCORMService;
	import com.eguru.faje.mvcs.services.ISCORMService;
	import com.eguru.faje.mvcs.services.config.SpecificationsParser;
	import com.eguru.faje.mvcs.services.config.ISpecificationsParser;
	import com.eguru.faje.mvcs.services.factories.StateFactory;
	import com.eguru.faje.mvcs.services.factories.IStateFactory;
	import com.eguru.faje.mvcs.services.LoadAssetsService;
	import com.eguru.faje.mvcs.services.ILoadAssetsService;
	import com.eguru.faje.mvcs.services.factories.ComponentFactory;
	import com.eguru.faje.mvcs.services.factories.FiltersFactory;
	import com.eguru.faje.mvcs.services.factories.IFiltersFactory;
	import com.eguru.faje.mvcs.services.factories.IComponentFactory;
	import com.eguru.faje.mvcs.services.config.PreloaderConfigLoadingService;
	import com.eguru.faje.mvcs.services.config.IPreloaderConfigLoadingService;
	import com.eguru.faje.mvcs.services.config.ConfigLoadingService;
	import com.eguru.faje.mvcs.services.config.IConfigLoadingService;
	import org.robotlegs.core.IInjector;
	/**
	 * @author Bruno Tachinardi
	 */
	public class BootstrapServices extends Object {
		
		public function BootstrapServices(injector:IInjector)
        {
            injector.mapSingletonOf(IConfigLoadingService, ConfigLoadingService);
			injector.mapSingletonOf(IPreloaderConfigLoadingService, PreloaderConfigLoadingService);
			injector.mapSingletonOf(IComponentFactory, ComponentFactory);
			injector.mapSingletonOf(IFiltersFactory, FiltersFactory);
			injector.mapSingletonOf(ILoadAssetsService, LoadAssetsService);
			injector.mapSingletonOf(IStateFactory, StateFactory);
			injector.mapSingletonOf(ISpecificationsParser, SpecificationsParser);
			injector.mapSingletonOf(ISCORMService, SCORMService);
        }
	}
}
