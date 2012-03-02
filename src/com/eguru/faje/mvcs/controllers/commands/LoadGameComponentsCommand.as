package com.eguru.faje.mvcs.controllers.commands {
	import com.eguru.faje.mvcs.models.data.fixed.FixedAssetsPaths;
	import com.eguru.faje.mvcs.controllers.events.RequestLoadAssetEvent;
	import com.eguru.faje.mvcs.models.data.AssetVO;
	import com.eguru.faje.mvcs.models.data.fixed.FixedAssetsNames;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import org.robotlegs.mvcs.Command;

	/**
	 * @author Bruno Tachinardi
	 */
	public class LoadGameComponentsCommand extends Command 
	{
		[Inject]
		public var assetModel : IAssetModel;
		
		override public function execute() : void
		{
			var assets : Vector.<AssetVO> = new Vector.<AssetVO>();
			assets.push(new AssetVO(FixedAssetsNames.BASE_CONFIG_FILE_NAME, FixedAssetsPaths.BASE_CONFIG_FILE_PATH, 10000));
			assetModel.AddAssetGroup(assets);
			dispatch(new RequestLoadAssetEvent(RequestLoadAssetEvent.LOAD_ALL_ASSETS));
		}
	}
}
