package com.eguru.faje.editor {
	import com.eguru.faje.editor.mvcs.views.EditorStageManagerView;
	import com.eguru.faje.mvcs.views.StageManagerView;
	import com.eguru.faje.mvcs.controllers.bootstraps.editor.BootstrapEditorCommands;
	import com.eguru.faje.mvcs.services.factories.IComponentFactory;
	import com.eguru.faje.mvcs.models.IStateMachineModel;
	import com.eguru.faje.mvcs.services.factories.IStateFactory;
	import com.eguru.faje.mvcs.controllers.bootstraps.BootstrapStates;
	import com.eguru.faje.mvcs.controllers.bootstraps.BootstrapStatemachine;
	import com.eguru.faje.mvcs.controllers.bootstraps.BootstrapComponents;
	import com.eguru.faje.mvcs.controllers.bootstraps.BootstrapViewMediators;
	import com.eguru.faje.mvcs.controllers.bootstraps.BootstrapClasses;
	import com.eguru.faje.mvcs.controllers.bootstraps.BootstrapCustomEventCommands;
	import com.eguru.faje.mvcs.controllers.bootstraps.BootstrapCommands;
	import com.eguru.faje.mvcs.controllers.bootstraps.BootstrapServices;
	import com.eguru.faje.mvcs.controllers.bootstraps.BootstrapModels;
	import com.eguru.faje.mvcs.controllers.bootstraps.BootstrapConfigValues;
	import org.robotlegs.mvcs.Context;

	import flash.display.DisplayObjectContainer;

	/**
	 * @author Bruno Tachinardi
	 */
	public class FajeEditorContext extends Context {
		
		public function FajeEditorContext(contextView : DisplayObjectContainer) 
		{
			super(contextView, true);
		}
		
		override public function startup():void
        {
            new BootstrapConfigValues(injector);
            new BootstrapModels(injector);
            new BootstrapServices(injector);
            new BootstrapEditorCommands(commandMap);
			new BootstrapCustomEventCommands(commandMap);
            new BootstrapClasses(injector);
            new BootstrapViewMediators(mediatorMap);
			new BootstrapComponents(injector.getInstance(IComponentFactory));
			new BootstrapStatemachine(injector.getInstance(IStateMachineModel));
			new BootstrapStates(injector.getInstance(IStateFactory));
			
			contextView.addChild(new EditorStageManagerView());
			
            super.startup();
		}
	}
}
