package com.eguru.faje.mvcs.models.data {
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import com.adobe.serialization.json.JSON;
	import com.eguru.faje.mvcs.services.config.ISpecificationsParser;
	import flash.display.Loader;
	import flash.utils.getDefinitionByName;
	import com.greensock.loading.display.ContentDisplay;
	import flash.text.Font;
	/**
	 * @author Bruno Tachinardi
	 */
	public class AssetVO 
	{
		private static const DEFAULT_CACHES_NUM : Number = 1;
		protected var _path : String;		
		protected var _name : String;
		protected var _loaded : Boolean;
		protected var _priority : int;
		protected var _content : *;
		protected var _cachedList : Vector.<Loader>;
		private var _firstCached : Loader;
		private var _useCache : Boolean;

		public function AssetVO(name : String, path : String, priority : int = 0, useCache : Boolean = true) 
		{
			_path = path;
			_name = name;
			_loaded = false;
			_cachedList = new Vector.<Loader>();
			_priority = priority;
			_useCache = useCache;
		}
		
		public function get priority() : int 
		{
			return _priority;
		}
		
		public function get name() : String 
		{
			return _name;
		}
		
		public function get path() : String 
		{
			return _path;
		}
		
		public function get loaded() : Boolean
		{
			return _loaded;
		}
		
		public function get content() : *
		{
			if (_content is ContentDisplay && _useCache)
			{
				StopContent(_content as ContentDisplay);
				if (_firstCached != null)
				{
					var value : Loader = _firstCached;
					_firstCached = null;
					value.cacheAsBitmap = true;
					return value;
				}
				if (_cachedList.length == 0)
				{
					return GenerateCache();
				}
				var returnContent : Loader = _cachedList.splice(0, 1)[0];				
				AddCache();
				returnContent.cacheAsBitmap = true;		
				return returnContent;
			}
			return _content;
		}

		private function StopContent(content : ContentDisplay) : void 
		{
		}
		
		private function GenerateCache() : Loader
		{
			if (!(_content is ContentDisplay)) return null;
			
			var contentDisplay : ContentDisplay = _content as ContentDisplay;
			var cachedAsset : Loader = new Loader();
			
			if (contentDisplay.rawContent is Loader)
			{
				var contentLoader : Loader = contentDisplay.rawContent as Loader;
				cachedAsset.loadBytes(contentLoader.contentLoaderInfo.bytes);				
			}				
			else
			{
				cachedAsset.loadBytes(LoaderInfo(Object(contentDisplay.rawContent)["loaderInfo"]).bytes);
			}
			cachedAsset.cacheAsBitmap = true;
			return cachedAsset;
		}

		private function AddCache() : void
		{		
			if (!(_content is ContentDisplay)) return;	
			GenerateCache().addEventListener(Event.COMPLETE, HandleCachedComplete);
		}

		private function HandleCachedComplete(event : Event) : void 
		{
			var cached : Loader = event.target as Loader;
			cached.removeEventListener(Event.COMPLETE, HandleCachedComplete);
			_cachedList.push(cached);
		}
		
		public function SetContent(content : *, parser : ISpecificationsParser) : void
		{
			_loaded = true;
			_content = content;
			if (_path.indexOf(".font.swf") != -1)
			{
				var FontLibrary : Class =  Class(getDefinitionByName(_name));
				Font.registerFont(FontLibrary);
			} else if (_path.indexOf(".json.txt") != -1)
			{
				parser.Parse(JSON.decode(content));
			}
			
			_firstCached = GenerateCache();
			
			for (var i : int = 0; i < DEFAULT_CACHES_NUM; i++) 
			{
				AddCache();
			}
		}
	}
}
