package com.eguru.faje.mvcs.models.data.quiz {
	/**
	 * @author Bruno Tachinardi
	 */
	public class QuizVersionVO 
	{
		protected var _version : String;
		protected var _dateVersion : String;
		
		public function QuizVersionVO(specification : Object) 
		{
			_version = specification["version"];
			_dateVersion = specification["dateVersion"];	
		}
		
		public function get version() : String
		{
			return _version;
		}
		
		public function get dateVersion() : String
		{
			return _dateVersion;
		}
	}
}
