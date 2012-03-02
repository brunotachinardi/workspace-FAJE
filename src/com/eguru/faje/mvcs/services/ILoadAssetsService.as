package com.eguru.faje.mvcs.services {
	import com.eguru.faje.mvcs.models.data.AssetVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface ILoadAssetsService 
	{
		function AddToQueue(asset : AssetVO) : void;
		function StartLoading() : void;
		function PauseLoading() : void;
		function ResumeLoading() : void;
		function Reset() : void;
	}
}
