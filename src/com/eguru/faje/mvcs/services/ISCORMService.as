package com.eguru.faje.mvcs.services {
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.models.data.quiz.QuizQuestionVO;
	import com.eguru.faje.mvcs.models.IQuizModel;
	import com.eguru.faje.mvcs.models.data.TimerVO;
	import com.eguru.faje.mvcs.models.data.NumberVariableVO;
	import com.eguru.faje.mvcs.models.data.quiz.QuizAnswerVO;
	import com.eguru.faje.fsm.core.IStateSystem;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface ISCORMService 
	{
		function SetOffline(offlineObject : Object) : void;
		function SetCompleted(varModel : IAppNumberVariableModel) : void;
		function SetFailed() : void;
		function SaveScorm() : void;
		function LoadScorm() : void;
		
		function SaveStates(machineSystem : IStateSystem) : void;
		function LoadStates(machineSystem : IStateSystem) : void;
		
		function SaveAnswers(answers : Vector.<QuizAnswerVO>) : void;
		function LoadAnswers(quizModel : IQuizModel) : Vector.<QuizAnswerVO>;
		
		function SaveCurrentQuestion(currentQuestion : QuizQuestionVO) : void;
		function LoadCurrentQuestion(quizModel : IQuizModel) : QuizQuestionVO
		
		function SaveVariable(variable : NumberVariableVO) : void;
		function LoadVariable(variable : NumberVariableVO) : Boolean;
		
		function SaveTimer(timer : TimerVO) : void;
		function LoadTimer(timer : TimerVO) : Boolean;
		
		function LoadStudentLevel() : int;
		
	}
}
