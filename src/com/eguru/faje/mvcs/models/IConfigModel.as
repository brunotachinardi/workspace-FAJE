package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.models.data.PreloaderConfigVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IConfigModel 
	{
		function SetPreloaderConfig(value : PreloaderConfigVO) : void;		
		function SetScreenSettings(width: Number, height : Number) : void;		
		function SetLanguageSettings(multilanguage : Boolean, currentLanguage : String) : void;
		function SetLoadingSettings(dynamicAssetsLoading : Boolean) : void;		
		
		function get preloaderConfig() : PreloaderConfigVO;
		function get screenWidth() : Number;
		function get screenHeight() : Number;
		function get multiLanguages() : Boolean;
		function get currentLanguage() : String;
		function get dynamicAssetLoading() : Boolean;
		function get preloaderConfigPath() : String;
	}
}
