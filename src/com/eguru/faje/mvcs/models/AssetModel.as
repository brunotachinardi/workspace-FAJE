package com.eguru.faje.mvcs.models {
	import com.eguru.faje.utils.sound.SoundObject;
	import com.eguru.faje.utils.sound.core.ISoundObject;
	import flash.media.Sound;
	import com.eguru.faje.mvcs.services.config.ISpecificationsParser;
	import org.robotlegs.mvcs.Actor;

	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.AssetVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class AssetModel extends Actor implements IAssetModel {
		
		protected var _assets : Vector.<AssetVO>;
		
		protected var _parser : ISpecificationsParser;
		
		[Inject]
		public var soundModel : ISoundModel;
		
		public function AssetModel() 
		{
			_assets = new Vector.<AssetVO>();
		}

		public function AddAsset(asset : AssetVO) : AssetVO {
			if (ContainAsset(asset)) return asset;
			if (ContainAssetByName(asset.name)) throw(new Error("The Asset name '" + asset.name + "' is already assigned to an existing asset object. Please rename one of them: names MUST be unique."));
			_assets.push(asset);
			return asset;
		}
		
		public function AddAssetGroup(assets : Vector.<AssetVO>) : void 
		{
			for each (var asset : AssetVO in assets) 
			{
				AddAsset(asset);				
			}
		}

		public function RemoveAsset(asset : AssetVO) : AssetVO {
			if (!ContainAsset(asset)) return asset;
			_assets.splice(_assets.indexOf(asset), 1);
			return asset;
		}

		public function ContainAsset(asset : AssetVO) : Boolean {
			return _assets.indexOf(asset) != -1;
		}

		public function ContainAssetByName(name : String) : Boolean {
			for each (var i : AssetVO in _assets) {
				if (i.name == name) return true;
			}
			return false;
		}

		public function GetAssetByName(name : String) : AssetVO {
			for each (var i : AssetVO in _assets) {
				if (i.name == name) return i;
			}
			return null;
		}

		public function IsAssetLoadedByName(name : String) : Boolean {
			return GetAssetByName(name).loaded;
		}

		public function GetAssetContentByName(name : String) : * {
			return GetAssetByName(name).content;
		}
		
		public function SetAssetContent(name : String, content : *) : void 
		{
			GetAssetByName(name).SetContent(content, _parser);
		}

		public function GetUnloadedAssets() : Vector.<AssetVO> {
			var unloadedAssets : Vector.<AssetVO> = new Vector.<AssetVO>();
			for each (var a : AssetVO in _assets) {
				if (!a.loaded) unloadedAssets.push(a);
			}
			
			unloadedAssets.sort(function(obj1 : AssetVO, obj2 : AssetVO) : int 
			{ 
				return obj1.priority > obj2.priority ? -1 : 1;
			});
			
			return unloadedAssets;
		}

		public function AddRawAssetGroup(assetsArray : Array) : Vector.<AssetVO> 
		{
			var assets : Vector.<AssetVO> = new Vector.<AssetVO>();
			for each (var o : Object in assetsArray) 
			{
				var priority : int = o.hasOwnProperty("priority") ? o["priority"] : 0;
				var useCache : Boolean = o.hasOwnProperty("useCache") ? o["useCache"] : true;

				assets.push(new AssetVO(o["id"], o["src"], priority, useCache));
			}
			AddAssetGroup(assets);
			return assets;
		}

		public function SetParser(parser : ISpecificationsParser) : void 
		{
			if (_parser != null) return;
			_parser = parser;
		}

		public function AddSoundInLayer(name : String, sound : Sound, layer : String) : ISoundObject 
		{
			return soundModel.AddSoundInLayer(new SoundObject(name, sound), layer);
		}
	}
}
