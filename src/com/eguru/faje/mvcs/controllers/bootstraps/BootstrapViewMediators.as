package com.eguru.faje.mvcs.controllers.bootstraps {
	import com.eguru.faje.mvcs.views.components.SoundComponentViewMediator;
	import com.eguru.faje.mvcs.views.components.SoundComponentView;
	import com.eguru.faje.mvcs.views.components.GraphicComponentViewMediator;
	import com.eguru.faje.mvcs.views.components.GraphicComponentView;
	import com.eguru.faje.mvcs.views.components.quiz.ConnectQuizViewMediator;
	import com.eguru.faje.mvcs.views.components.quiz.MultiAlternativeQuizComponentViewMediator;
	import com.eguru.faje.mvcs.views.components.quiz.ConnectQuizView;
	import com.eguru.faje.mvcs.views.components.TrackerAnimationComponentViewMediator;
	import com.eguru.faje.mvcs.views.components.TrackerAnimationComponentView;
	import com.eguru.faje.mvcs.views.components.quiz.MultiAlternativeQuizComponentView;
	import com.eguru.faje.mvcs.views.components.AnimationComponentViewMediator;
	import com.eguru.faje.mvcs.views.components.AnimationComponentView;
	import com.eguru.faje.mvcs.views.components.TextBoxComponentViewMediator;
	import com.eguru.faje.mvcs.views.components.TextBoxComponentView;
	import com.eguru.faje.mvcs.views.components.ButtonComponentViewMediator;
	import com.eguru.faje.mvcs.views.components.ButtonComponentView;
	import com.eguru.faje.mvcs.views.components.TrackerTextComponentViewMediator;
	import com.eguru.faje.mvcs.views.components.TrackerTextComponentView;
	import com.eguru.faje.mvcs.views.components.TrackerBarComponentViewMediator;
	import com.eguru.faje.mvcs.views.components.TrackerBarComponentView;
	import com.eguru.faje.mvcs.views.StageManagerViewMediator;
	import com.eguru.faje.mvcs.views.StageManagerView;
	import org.robotlegs.core.IMediatorMap;
	/**
	 * @author Bruno Tachinardi
	 */
	public class BootstrapViewMediators extends Object 
	{
		public function BootstrapViewMediators(mediatorMap:IMediatorMap)
        {
            mediatorMap.mapView(StageManagerView, StageManagerViewMediator);
			mediatorMap.mapView(TrackerBarComponentView, TrackerBarComponentViewMediator);
			mediatorMap.mapView(TrackerTextComponentView, TrackerTextComponentViewMediator);
			mediatorMap.mapView(ButtonComponentView, ButtonComponentViewMediator);
			mediatorMap.mapView(TextBoxComponentView, TextBoxComponentViewMediator);
			mediatorMap.mapView(AnimationComponentView, AnimationComponentViewMediator);
			mediatorMap.mapView(MultiAlternativeQuizComponentView, MultiAlternativeQuizComponentViewMediator);
			mediatorMap.mapView(ConnectQuizView, ConnectQuizViewMediator);
			mediatorMap.mapView(TrackerAnimationComponentView, TrackerAnimationComponentViewMediator);
			mediatorMap.mapView(GraphicComponentView, GraphicComponentViewMediator);
			mediatorMap.mapView(SoundComponentView, SoundComponentViewMediator);
        }
	}
}
