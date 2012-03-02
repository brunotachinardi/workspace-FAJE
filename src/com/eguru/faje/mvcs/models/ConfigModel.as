package com.eguru.faje.mvcs.models 
{
	import com.eguru.faje.mvcs.controllers.events.ConfigEvent;
	import org.robotlegs.mvcs.Actor;
	import com.eguru.faje.mvcs.models.IConfigModel;
	import com.eguru.faje.mvcs.models.data.PreloaderConfigVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ConfigModel extends Actor implements IConfigModel 
	{
		
		protected var _preloaderConfig : PreloaderConfigVO;
		protected var _screenWidth : Number;
		protected var _screenHeight : Number;
		protected var _multiLanguages : Boolean;
		protected var _dynamicAssetLoading : Boolean;
		protected var _currentLanguage : String;
		
		public function ConfigModel() 
		{

		}

		public function get preloaderConfig() : PreloaderConfigVO {
			return _preloaderConfig;
		}

		public function SetPreloaderConfig(value : PreloaderConfigVO) : void 
		{
			_preloaderConfig = value;
			dispatch(new ConfigEvent(ConfigEvent.PRELOADER_CONFIG_LOADED));
		}
		
		public function SetScreenSettings(width: Number, height : Number) : void
		{
			_screenWidth = width;
			_screenHeight = height;
		}
		
		public function SetLanguageSettings(multilanguage : Boolean, currentLanguage : String) : void
		{
			_multiLanguages = multilanguage;
			_currentLanguage = currentLanguage;
		}
		
		public function SetLoadingSettings(dynamicAssetsLoading : Boolean) : void
		{
			_dynamicAssetLoading = dynamicAssetsLoading;
		}
		
		public function get screenWidth() : Number
		{
			return _screenWidth;
		}
		
		public function get screenHeight() : Number
		{
			return _screenHeight;
		}
		
		public function get multiLanguages() : Boolean
		{
			return _multiLanguages;
		}
		
		public function get currentLanguage() : String
		{
			return _currentLanguage;
		}
		
		public function get dynamicAssetLoading() : Boolean
		{
			return _dynamicAssetLoading;
		}

		public function get preloaderConfigPath() : String {
			return "config/preloader.json.txt";
		}
		
	}
}
