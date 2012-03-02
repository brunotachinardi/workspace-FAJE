package {
	import com.eguru.faje.editor.FajeEditorContext;
	import com.greensock.loading.XMLLoader;
	import com.greensock.loading.DataLoader;
	import com.greensock.loading.MP3Loader;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.VideoLoader;
	import com.greensock.loading.ImageLoader;
	import com.greensock.loading.LoaderMax;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.display.MovieClip;

	/**
	 * @author Bruno Tachinardi
	 */
	public class FAJEEditor extends MovieClip 
	{
		private var _context : FajeEditorContext;
		
		public function FAJEEditor() 
		{
			var context:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			LoaderMax.defaultContext = context;
			LoaderMax.activate([ImageLoader, VideoLoader, SWFLoader, MP3Loader, DataLoader, XMLLoader]);
			_context = new FajeEditorContext(this);
		}
	}
}
