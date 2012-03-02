package com.eguru.faje.mvcs.models.data {
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.models.IComponentModel;
	import com.eguru.faje.mvcs.models.ITextPropertiesModel;
	import com.eguru.faje.mvcs.models.IDisplayPropertiesModel;
	/**
	 * @author Bruno Tachinardi
	 */
	public class SpecificationsModelsVO 
	{
		private var _displayModel : IDisplayPropertiesModel;
		private var _textPropertiesModel : ITextPropertiesModel;
		private var _componentModel : IComponentModel;
		private var _varsModel : IAppNumberVariableModel;
		private var _textModel : ITextsModel;

		public function SpecificationsModelsVO(display : IDisplayPropertiesModel, textPropertiesModel : ITextPropertiesModel, component : IComponentModel, varsModel : IAppNumberVariableModel, textModel : ITextsModel) 
		{
			_displayModel = display;
			_textPropertiesModel = textPropertiesModel;
			_componentModel = component;
			_varsModel = varsModel;
			_textModel = textModel;
		}
		
		public function get displayModel() : IDisplayPropertiesModel
		{
			return _displayModel;
		}
		
		public function get textPropertiesModel() : ITextPropertiesModel
		{
			return _textPropertiesModel;
		}
		
		public function get textModel() : ITextsModel
		{
			return _textModel;
		}		
		
		public function get componentsModel() : IComponentModel
		{
			return _componentModel;
		}
		
		public function get varsModel() : IAppNumberVariableModel
		{
			return _varsModel;
		}
	}
}
