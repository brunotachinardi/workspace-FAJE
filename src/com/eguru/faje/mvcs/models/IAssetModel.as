package com.eguru.faje.mvcs.models {
	import flash.media.Sound;
	import com.eguru.faje.utils.sound.core.ISoundObject;
	import com.eguru.faje.mvcs.services.config.ISpecificationsParser;
	import com.eguru.faje.mvcs.models.data.AssetVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IAssetModel 
	{
		function SetParser(parser : ISpecificationsParser) : void;
		function AddAsset(asset : AssetVO) : AssetVO;
		function AddAssetGroup(assets : Vector.<AssetVO>) : void;
		function AddRawAssetGroup(assetsArray : Array) : Vector.<AssetVO>;
		function RemoveAsset(asset : AssetVO) : AssetVO;
		function ContainAsset(asset : AssetVO) : Boolean;
		function ContainAssetByName(name : String) : Boolean;
		function GetAssetByName(name : String) : AssetVO;
		function IsAssetLoadedByName(name : String) : Boolean;
		function SetAssetContent(name : String, content : *) : void;
		function GetAssetContentByName(name : String) : *;
		function GetUnloadedAssets() : Vector.<AssetVO>;
		function AddSoundInLayer(name : String, sound : Sound, layer : String) : ISoundObject;
	}
}
