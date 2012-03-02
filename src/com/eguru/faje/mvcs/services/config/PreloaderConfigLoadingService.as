package com.eguru.faje.mvcs.services.config {
	import com.eguru.faje.mvcs.models.data.SpecificationsParseResultVO;
	import com.eguru.faje.mvcs.models.data.fixed.FixedAssetsPaths;
	import com.eguru.faje.mvcs.models.data.fixed.FixedAssetsNames;
	import com.eguru.faje.mvcs.controllers.events.PreloaderConfigLoadingServiceEvent;
	import com.greensock.events.LoaderEvent;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.services.BaseConfigJsonLoadingService;
	import com.eguru.faje.mvcs.models.data.AssetVO;
	import com.eguru.faje.mvcs.models.data.PreloaderConfigVO;
	import com.greensock.loading.LoaderMax;
	import com.eguru.faje.mvcs.models.IConfigModel;

	/**
	 * @author Bruno Tachinardi
	 */
	public class PreloaderConfigLoadingService extends BaseConfigJsonLoadingService implements IPreloaderConfigLoadingService {
		
		private static const PRELOADER_CONFIG_NAME : String = "Preloader Config";
		
		[Inject]
		public var config : IConfigModel;		
		
		[Inject]
		public var assetModel : IAssetModel;
		
		[Inject]
		public var parser : ISpecificationsParser;
		
		public function PreloaderConfigLoadingService() 
		{
			super(PRELOADER_CONFIG_NAME);
		}

		public function LoadPreloaderConfig(path : String) : void 
		{
			_loader.append(LoaderMax.parse(path, {name : PRELOADER_CONFIG_NAME}));
			_loader.load();
			
			var event : PreloaderConfigLoadingServiceEvent = new PreloaderConfigLoadingServiceEvent(PreloaderConfigLoadingServiceEvent.LOAD_REQUESTED);
			dispatch(event);
		}	
		
		 
		override protected function UpdateModel(data : Object) : Boolean {
						
			var parseResult : SpecificationsParseResultVO = parser.Parse(data);
			assetModel.AddAsset(new AssetVO(FixedAssetsNames.RESOURCES_CONFIG_FILE_NAME, FixedAssetsPaths.RESOURCES_CONFIG_FILE_PATH));
			trace("Preloader Properties Parsed");
						
			//Sets the config
			config.SetPreloaderConfig(new PreloaderConfigVO(parseResult.components));
			config.SetScreenSettings(Number(data["screenW"]), Number(data["screenH"]));
			config.SetLanguageSettings(Boolean(data["multLang"]), String(data["lang"]));
			config.SetLoadingSettings(Boolean(data["dynamicLoading"]));
			return true;
		}
		
		override protected function LoadErrorHandler(event : LoaderEvent) : void 
		{ 
			var evt : PreloaderConfigLoadingServiceEvent = new PreloaderConfigLoadingServiceEvent(PreloaderConfigLoadingServiceEvent.LOAD_FAILED);
			dispatch(evt);
		}
		
	    override protected function DispatchLoadCompleted() : void 
		{ 
			var evt : PreloaderConfigLoadingServiceEvent = new PreloaderConfigLoadingServiceEvent(PreloaderConfigLoadingServiceEvent.LOAD_COMPLETED);
			dispatch(evt);			
		}

	    override protected function DispatchLoadFailed() : void 
		{ 
			var evt : PreloaderConfigLoadingServiceEvent = new PreloaderConfigLoadingServiceEvent(PreloaderConfigLoadingServiceEvent.INVALID_DATA);
			dispatch(evt);
		}
	}
}
