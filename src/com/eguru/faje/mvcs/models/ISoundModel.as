package com.eguru.faje.mvcs.models {
	import com.eguru.faje.utils.sound.core.ISoundObject;
	import com.eguru.faje.utils.sound.core.ISoundObjectContainer;

	/**
	 * @author Bruno Tachinardi
	 */
	public interface ISoundModel extends ISoundObjectContainer
	{
		function AddSoundInLayer(sound : ISoundObject, layer : String) : ISoundObject;
		function ContainsSound(soundItem : ISoundObject) : Boolean;
		function Get(name : String) : ISoundObject;
		function AddEmptyLayer(name : String) : ISoundObjectContainer;
		function AddLayer(layer : ISoundObjectContainer) : ISoundObjectContainer;
		function ContainsLayer(targetLayer : ISoundObjectContainer) : Boolean;
		function GetLayer(name : String) : ISoundObjectContainer;
		function RemoveLayerByName(name : String) : Boolean;
		function RemoveLayer(layer : ISoundObjectContainer) : Boolean;
		function RemoveAllLayers() : void;
	}
}
