package com.eguru.faje.mvcs.controllers.bootstraps {
	import com.eguru.faje.mvcs.models.SoundModel;
	import com.eguru.faje.mvcs.models.ISoundModel;
	import com.eguru.faje.mvcs.models.QuizModel;
	import com.eguru.faje.mvcs.models.IQuizModel;
	import com.eguru.faje.mvcs.models.TextsModel;
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.models.TextPropertiesModel;
	import com.eguru.faje.mvcs.models.ITextPropertiesModel;
	import com.eguru.faje.mvcs.models.EventsReceptorModel;
	import com.eguru.faje.mvcs.models.IEventsReceptorModel;
	import com.eguru.faje.mvcs.models.TimerModel;
	import com.eguru.faje.mvcs.models.ITimerModel;
	import com.eguru.faje.mvcs.models.AppNumberVariableModel;
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.models.ComponentModel;
	import com.eguru.faje.mvcs.models.AssetModel;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.IComponentModel;
	import com.eguru.faje.mvcs.models.ConfigModel;
	import com.eguru.faje.mvcs.models.DisplayPropertiesModel;
	import com.eguru.faje.mvcs.models.IDisplayPropertiesModel;
	import com.eguru.faje.mvcs.models.IConfigModel;
	import com.eguru.faje.mvcs.models.StateMachineModel;
	import com.eguru.faje.mvcs.models.IStateMachineModel;
	import org.robotlegs.core.IInjector;
	/**
	 * @author Bruno Tachinardi
	 */
	public class BootstrapModels extends Object 
	{
		public function BootstrapModels(injector:IInjector)
        {
			injector.mapSingletonOf(IStateMachineModel, StateMachineModel);
			injector.mapSingletonOf(IConfigModel, ConfigModel);
			injector.mapSingletonOf(IDisplayPropertiesModel, DisplayPropertiesModel);
			injector.mapSingletonOf(IComponentModel, ComponentModel);
			injector.mapSingletonOf(IAssetModel, AssetModel);
			injector.mapSingletonOf(IAppNumberVariableModel, AppNumberVariableModel);
			injector.mapSingletonOf(ITimerModel, TimerModel);
			injector.mapSingletonOf(IEventsReceptorModel, EventsReceptorModel);
			injector.mapSingletonOf(ITextPropertiesModel, TextPropertiesModel);
			injector.mapSingletonOf(ITextsModel, TextsModel);
			injector.mapSingletonOf(IQuizModel, QuizModel);
			injector.mapSingletonOf(ISoundModel, SoundModel);
        }
	}
}
