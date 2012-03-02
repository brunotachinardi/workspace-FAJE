package com.eguru.faje.mvcs.services.factories {
	import flash.filters.BitmapFilter;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IFiltersFactory 
	{
		function ParseFilter(specifications : Object) : BitmapFilter;
	}
}
