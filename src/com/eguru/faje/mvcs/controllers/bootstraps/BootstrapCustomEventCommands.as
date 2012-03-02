package com.eguru.faje.mvcs.controllers.bootstraps {
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomSetCompletedCommand;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomSetFailedCommand;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomSetVariableToMaxCommand;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomResetQuizCommand;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomSetVariableCommand;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomPlayTimerCommand;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomStopTimerCommand;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomSetQuizByRandomFeedCommand;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomSetTextByFeedCommand;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomSetTextCommand;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomRegisterTimerTickOpCommand;
	import org.robotlegs.core.ICommandMap;
	import com.eguru.faje.mvcs.controllers.commands.custom.CustomCreateTimerCommand;
	import com.eguru.faje.mvcs.controllers.events.CustomEvent;
	/**
	 * @author Bruno Tachinardi
	 */
	public class BootstrapCustomEventCommands extends Object 
	{
		public function BootstrapCustomEventCommands(commandMap : ICommandMap)
        {
			//Startup
			commandMap.mapEvent(CustomEvent.CREATE_TIMER, CustomCreateTimerCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.STOP_TIMER, CustomStopTimerCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.START_TIMER, CustomPlayTimerCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.REGISTER_TIMER_TICK_OP, CustomRegisterTimerTickOpCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.SET_TEXT, CustomSetTextCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.SET_TEXT_BY_FEED, CustomSetTextByFeedCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.SET_QUIZ_BY_RANDOM_FEED, CustomSetQuizByRandomFeedCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.SET_VARIABLE, CustomSetVariableCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.SET_VARIABLE_TO_MAX, CustomSetVariableToMaxCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.RESET_QUIZ, CustomResetQuizCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.SET_FAILED, CustomSetFailedCommand, CustomEvent);
			commandMap.mapEvent(CustomEvent.SET_COMPLETED, CustomSetCompletedCommand, CustomEvent);
		}
	}
}
