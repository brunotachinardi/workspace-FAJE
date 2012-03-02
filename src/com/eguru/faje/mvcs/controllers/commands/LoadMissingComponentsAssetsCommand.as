package com.eguru.faje.mvcs.controllers.commands {
	import com.eguru.faje.mvcs.services.ILoadAssetsService;
	import com.eguru.faje.mvcs.models.data.AssetVO;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Bruno Tachinardi
	 */
	public class LoadMissingComponentsAssetsCommand extends Command 
	{
		[Inject]
		public var assetsModel : IAssetModel;
		
		[Inject]
		public var loadAssetsService : ILoadAssetsService;
		
		override public function execute() : void
		{
			loadAssetsService.Reset();
			var assets : Vector.<AssetVO> = assetsModel.GetUnloadedAssets();
			if (assets.length == 0) return;
			
			for each (var a : AssetVO in assets) {
				loadAssetsService.AddToQueue(a);
			}
			
			loadAssetsService.StartLoading();
		}
	}
}
