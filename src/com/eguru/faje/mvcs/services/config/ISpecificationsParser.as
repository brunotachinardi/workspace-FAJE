package com.eguru.faje.mvcs.services.config {
	import com.eguru.faje.mvcs.models.data.SpecificationsParseResultVO;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface ISpecificationsParser 
	{
		function Parse(specifications : Object) : SpecificationsParseResultVO;
	}
}
