package 
{
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.VideoLoader;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import com.eguru.faje.FajeContext;
	import flash.display.MovieClip;

	public class FAJE extends MovieClip
	{
		protected var _context : FajeContext;
		
		public function FAJE()
		{
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			LoaderMax.defaultContext = context;
			LoaderMax.activate([ImageLoader, VideoLoader, SWFLoader, MP3Loader, DataLoader, XMLLoader]);
			_context = new FajeContext(this);
		}
	}

}
