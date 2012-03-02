package com.eguru.faje.mvcs.services.config {
	import com.eguru.faje.mvcs.controllers.events.DebugEvent;
	import com.eguru.faje.mvcs.services.ISCORMService;
	import com.eguru.faje.mvcs.controllers.events.CustomEvent;
	import org.robotlegs.mvcs.Actor;
	import com.eguru.faje.mvcs.models.ITimerModel;
	import com.eguru.faje.mvcs.models.data.fsm.core.ICustomState;
	import com.eguru.faje.mvcs.views.StageManagerView;
	import com.eguru.faje.mvcs.models.IQuizModel;
	import com.eguru.faje.mvcs.models.ITextsModel;
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.models.IStateMachineModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.models.data.TextPropertiesVO;
	import com.eguru.faje.mvcs.models.data.DisplayPropertiesVO;
	import com.eguru.faje.mvcs.models.data.AssetVO;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.IComponentModel;
	import com.eguru.faje.mvcs.models.ITextPropertiesModel;
	import com.eguru.faje.mvcs.models.IDisplayPropertiesModel;
	import com.eguru.faje.mvcs.models.data.SpecificationsParseResultVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class SpecificationsParser extends Actor implements ISpecificationsParser {
		
		[Inject]
		public var displayPropertiesModel : IDisplayPropertiesModel;
		
		[Inject]
		public var textPropertiesModel : ITextPropertiesModel;
		
		[Inject]
		public var componentModel : IComponentModel;
		
		[Inject]
		public var assetModel : IAssetModel;
		
		[Inject]
		public var stateMachineModel : IStateMachineModel;
		
		[Inject]
		public var variables : IAppNumberVariableModel;
		
		[Inject]
		public var textsModel : ITextsModel;
		
		[Inject]
		public var quizModel : IQuizModel;
		
		[Inject]
		public var timerModel : ITimerModel;
		
		[Inject]
		public var scormService : ISCORMService;
		
		public function Parse(specifications : Object) : SpecificationsParseResultVO
		{
			assetModel.SetParser(this);
			
			//Parse Scorm configurations
			if (specifications.hasOwnProperty("offline"))
			{
				if (specifications["offline"]) 
				{
					scormService.SetOffline(specifications["offlineObject"]);
				}
			}
			
			//Parse Cpu stats configurations
			if (specifications.hasOwnProperty("showCPUStats"))
			{
				if (specifications["showCPUStats"]) 
				{
					dispatch(new DebugEvent(DebugEvent.ACTIVATE_CPU_STATS));
				}
			}
			
			//Parse assets
			var assets : Vector.<AssetVO>;			
			if (specifications.hasOwnProperty("assets"))
				assets = assetModel.AddRawAssetGroup(specifications["assets"] as Array);
				
			//Parse Display Properties
			var displayProperties : Vector.<DisplayPropertiesVO>;	
			if (specifications.hasOwnProperty("displayProperties"))
				displayProperties = displayPropertiesModel.AddRawDisplayPropertyGroup(specifications["displayProperties"] as Array);
		
			//Parse Text Properties
			var textProperties : Vector.<TextPropertiesVO>;	
			if (specifications.hasOwnProperty("textProperties"))
				textProperties = textPropertiesModel.AddRawTextPropertyGroup(specifications["textProperties"] as Array);
		
			//Parse Components
			var components : Vector.<ComponentVO>;	 
			if (specifications.hasOwnProperty("components"))
				components = componentModel.AddRawComponentGroup(specifications["components"] as Array);	
				
				
			//Parse states
			var states : Vector.<ICustomState>;	 			
				states = stateMachineModel.AddRawStatesGroup(specifications["states"] as Array);	
				
			//Parse Variables				
			if (specifications.hasOwnProperty("variables"))	
			{
				for each (var variable : Object in specifications["variables"]) {
					if (variable.hasOwnProperty("max"))
					{
						if (variable.hasOwnProperty("min"))
						{
							variables.SetVariableProperties(variable["name"], variable["start"], variable["max"], variable["min"]);
						}	
						else
						{
							variables.SetVariableProperties(variable["name"], variable["start"], variable["max"]);						
						}
					}
					else
						variables.SetVariable(variable["name"], variable["start"]);
				}
			}
			
			//Parse Timers				
			if (specifications.hasOwnProperty("timers"))	
			{
				for each (var timer : Object in specifications["timers"]) 
				{					
					var timerName : String = timer["name"];
					var autoPlay : Boolean = timer.hasOwnProperty("autoPlay") ? timer["autoPlay"] : false;
					var delay : Number = timer.hasOwnProperty("delay") ? timer["delay"] : 1000;
					var repeat : Number = timer.hasOwnProperty("repeat") ? timer["repeat"] : 0;
					if (!timerModel.ContainsTimer(timerName)) 
					{
						timerModel.AddTimer(timerName, autoPlay, delay, repeat);
					} 
					else if (autoPlay) 
					{
						timerModel.StartTimer(timerName);
					}
					
					if (timer.hasOwnProperty("variables"))
					{
						for each (var v : Object in timer["variables"]) 
						{
							v["timer"] = timerName;
							dispatch(new CustomEvent(CustomEvent.REGISTER_TIMER_TICK_OP, null, v));
						}
					}
				}			
			}
			
			//Parse the texts feeds				
			if (specifications.hasOwnProperty("texts"))	
			{
				textsModel.AddTextFeed(specifications["texts"]);			
			}
			
			//Parse the quiz
			if (specifications.hasOwnProperty("quiz"))	
			{
				quizModel.AddRawQuestions(specifications["quiz"]);			
			}
			
			//Parse the general configurations
			if (specifications.hasOwnProperty("config"))	
			{
				if (Object(specifications["config"]).hasOwnProperty("transitionTweenDuration"))
					StageManagerView.TWEEN_DURATION = specifications["config"]["transitionTweenDuration"];
					
				if (Object(specifications["config"]).hasOwnProperty("transitionTweenEnterSpec"))
					StageManagerView.TWEEN_ENTER = specifications["config"]["transitionTweenEnterSpec"];
					
				if (Object(specifications["config"]).hasOwnProperty("transitionTweenExitSpec"))
					StageManagerView.TWEEN_EXIT = specifications["config"]["transitionTweenExitSpec"];

				if (Object(specifications["config"]).hasOwnProperty("transitionRandomDelay"))
					StageManagerView.RANDOM_DELAY = specifications["config"]["transitionRandomDelay"];
			}
			
			return new SpecificationsParseResultVO(components, displayProperties, textProperties, assets, states);
		}
	}
}
