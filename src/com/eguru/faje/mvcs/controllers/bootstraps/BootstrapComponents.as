package com.eguru.faje.mvcs.controllers.bootstraps {
	import com.eguru.faje.mvcs.views.components.SoundComponentView;
	import com.eguru.faje.mvcs.models.data.components.SoundComponentVO;
	import com.eguru.faje.mvcs.views.components.quiz.ConnectQuizView;
	import com.eguru.faje.mvcs.models.data.components.quiz.ConnectQuizVO;
	import com.eguru.faje.mvcs.views.components.TrackerAnimationComponentView;
	import com.eguru.faje.mvcs.models.data.components.TrackerAnimationComponentVO;
	import com.eguru.faje.mvcs.views.components.quiz.MultiAlternativeQuizComponentView;
	import com.eguru.faje.mvcs.models.data.components.quiz.MultiAlternativeQuizComponentVO;
	import com.eguru.faje.mvcs.views.components.AnimationComponentView;
	import com.eguru.faje.mvcs.models.data.components.AnimationComponentVO;
	import com.eguru.faje.mvcs.views.components.ButtonComponentView;
	import com.eguru.faje.mvcs.models.data.components.ButtonComponentVO;
	import com.eguru.faje.mvcs.models.data.components.ComponentsContainerVO;
	import com.eguru.faje.mvcs.views.components.TextBoxComponentView;
	import com.eguru.faje.mvcs.models.data.components.TextBoxComponentVO;
	import com.eguru.faje.mvcs.views.components.TrackerTextComponentView;
	import com.eguru.faje.mvcs.models.data.components.TrackerTextComponentVO;
	import com.eguru.faje.mvcs.views.components.TrackerBarComponentView;
	import com.eguru.faje.mvcs.views.components.GraphicComponentView;
	import com.eguru.faje.mvcs.models.data.components.TrackerBarComponentVO;
	import com.eguru.faje.mvcs.models.data.components.GraphicComponentVO;
	import com.eguru.faje.mvcs.services.factories.IComponentFactory;
	/**
	 * @author Bruno Tachinardi
	 */
	public class BootstrapComponents extends Object
	{
		public function BootstrapComponents(componentFactory : IComponentFactory) 
		{
			componentFactory.MapComponent("Graphic", GraphicComponentVO, GraphicComponentView);
			componentFactory.MapComponent("TrackerBar", TrackerBarComponentVO, TrackerBarComponentView);
			componentFactory.MapComponent("TrackerText", TrackerTextComponentVO, TrackerTextComponentView);
			componentFactory.MapComponent("TextBox", TextBoxComponentVO, TextBoxComponentView);
			componentFactory.MapComponent("ComponentsContainer", ComponentsContainerVO);
			componentFactory.MapComponent("Button", ButtonComponentVO, ButtonComponentView);
			componentFactory.MapComponent("Animation", AnimationComponentVO, AnimationComponentView);
			componentFactory.MapComponent("MultiAlternativeQuiz", MultiAlternativeQuizComponentVO, MultiAlternativeQuizComponentView);
			componentFactory.MapComponent("ConnectQuiz", ConnectQuizVO, ConnectQuizView);
			componentFactory.MapComponent("TrackerAnimation", TrackerAnimationComponentVO, TrackerAnimationComponentView);
			componentFactory.MapComponent("Sound", SoundComponentVO, SoundComponentView);
		}
	}
}
