package com.eguru.faje.mvcs.services {

	import com.eguru.faje.mvcs.controllers.events.StateMachineEvent;
	import com.eguru.faje.mvcs.services.utils.LoaderPropertiesDefaultConfig;
	import com.eguru.faje.mvcs.models.data.ApplicationFixedVariableNames;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.greensock.loading.core.LoaderCore;
	import com.eguru.faje.mvcs.models.data.AssetVO;
	import com.eguru.faje.mvcs.controllers.events.LoadAssetsServiceEvent;
	import com.greensock.events.LoaderEvent;
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.greensock.loading.LoaderMax;
	import org.robotlegs.mvcs.Actor;

	/**
	 * @author Bruno Tachinardi
	 */
	public class LoadAssetsService extends Actor implements ILoadAssetsService
	{
		
		[Inject]
		public var appNumVarModel : IAppNumberVariableModel;
		
		[Inject]
		public var assetModel : IAssetModel;
		
		protected var _loader : LoaderMax;
		
		public function LoadAssetsService() 
		{
			_loader = new LoaderMax({name:"assets_loader", onComplete:LoadCompleteHandler, onProgress:LoadProgressHandler, onError:LoadErrorHandler});
			_loader.maxConnections = 10;	
		}

		public function AddToQueue(asset : AssetVO) : void 
		{
			var assetLoader : LoaderCore = LoaderMax.parse(asset.path, { name : asset.name });
			assetLoader = new LoaderPropertiesDefaultConfig().SetLoaderDefaultProperties(assetLoader);
			_loader.append(assetLoader);
		}		

		public function StartLoading() : void 
		{
			appNumVarModel.SetVariableProperties(ApplicationFixedVariableNames.LOAD_ASSET_PROGRESS, 0);
			appNumVarModel.SetVariableProperties(ApplicationFixedVariableNames.LOAD_ASSET_BYTES, 0);
			_loader.load();
		}

		public function PauseLoading() : void 
		{
			if (!_loader.paused) _loader.pause();
		}

		public function ResumeLoading() : void 
		{
			if (_loader.paused) _loader.resume();
		}
		
		protected function LoadCompleteHandler(event : LoaderEvent) : void 
		{ 
			appNumVarModel.SetVariable(ApplicationFixedVariableNames.LOAD_ASSET_PROGRESS, 1);
			var loaders : Array = _loader.getChildren();
			for each (var i : LoaderCore in loaders) 
			{
				assetModel.SetAssetContent(i.name, i.content);
			}
			
			trace("Completed downloading " + loaders.length + " assets.");			
			
			var evt : LoadAssetsServiceEvent = new LoadAssetsServiceEvent(LoadAssetsServiceEvent.LOAD_COMPLETED);
			dispatch(evt);
			
			dispatch(new StateMachineEvent(StateMachineEvent.ASSETS_LOADED_MESSAGE));
		}
		
		protected function LoadProgressHandler(event : LoaderEvent) : void 
		{ 
			appNumVarModel.SetVariableProperties(ApplicationFixedVariableNames.LOAD_ASSET_PROGRESS, _loader.progress);
			appNumVarModel.SetVariableProperties(ApplicationFixedVariableNames.LOAD_ASSET_BYTES, Math.floor(_loader.bytesLoaded/1000), Math.floor(_loader.bytesTotal/1000));
			var evt : LoadAssetsServiceEvent = new LoadAssetsServiceEvent(LoadAssetsServiceEvent.LOAD_PROGRESS);
			dispatch(evt);
		}
		
		protected function LoadErrorHandler(event : LoaderEvent) : void 
		{ 
			var evt : LoadAssetsServiceEvent = new LoadAssetsServiceEvent(LoadAssetsServiceEvent.LOAD_FAILED);
			dispatch(evt);
		}

		public function Reset() : void 
		{
			_loader.empty();
		}
	}
}
