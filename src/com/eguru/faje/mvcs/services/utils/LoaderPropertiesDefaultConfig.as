package com.eguru.faje.mvcs.services.utils {
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.core.LoaderCore;
	/**
	 * @author Bruno Tachinardi
	 */
	public class LoaderPropertiesDefaultConfig 
	{
		public function SetLoaderDefaultProperties(loader : LoaderCore) : LoaderCore 
		{
			if (loader is MP3Loader)
			{
				var mp3Loader : MP3Loader = loader as MP3Loader;
				loader = SetMP3Loader(mp3Loader);
			}
			return loader;
		}

		private function SetMP3Loader(mp3Loader : MP3Loader) : LoaderCore 
		{
			mp3Loader.vars = {autoPlay : false};
			return mp3Loader;
		}
	}
}
