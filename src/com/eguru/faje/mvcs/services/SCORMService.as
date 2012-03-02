package com.eguru.faje.mvcs.services {
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import flash.external.ExternalInterface;
	import com.eguru.faje.mvcs.models.data.quiz.QuizAlternativeVO;
	import com.eguru.faje.mvcs.models.data.quiz.QuizQuestionVO;
	import com.eguru.faje.mvcs.models.IQuizModel;
	import com.eguru.faje.mvcs.models.data.TimerVO;
	import com.adobe.serialization.json.JSON;
	import com.eguru.faje.mvcs.models.data.fsm.CustomComplexState;
	import com.eguru.faje.fsm.core.IStateContainer;
	import com.eguru.faje.fsm.core.IState;
	import com.eguru.faje.mvcs.models.data.quiz.QuizAnswerVO;
	import com.eguru.faje.mvcs.services.ISCORMService;
	import com.eguru.faje.mvcs.models.data.NumberVariableVO;
	import com.eguru.faje.fsm.core.IStateSystem;

	/**
	 * @author Bruno Tachinardi
	 */
	public class SCORMService implements ISCORMService 
	{
		
		private static const STATUS_INCOMPLETE : String = "incomplete";
		private static const STATUS_COMPLETE : String = "completed";
		
		protected var objeto_scorm : Object;
		protected var _offline : Boolean;
		
		public function SCORMService()
		{
			objeto_scorm = new Object();
		}
		
		public function SetOffline(offlineObject : Object) : void 
		{
			objeto_scorm = offlineObject;
			_offline = true;
		}
		
		public function SetCompleted(varModel : IAppNumberVariableModel) : void 
		{
			if (lessonLocation["failed"] == null) lessonLocation["failed"] = 0;
			objeto_scorm["lessonStatus"]["status"] = STATUS_COMPLETE;
			
			var timeValue : Number = varModel.GetVariableValue("Time");
			var timeMax : Number = varModel.GetVariableMax("Time");
			var pointsValue : Number = varModel.GetVariableValue("Points") - (lessonLocation["failed"] > 0 ? 50 : 0);
			pointsValue = pointsValue < 0 ? 0 : pointsValue;
			var pointsMax : Number = varModel.GetVariableMax("Points");
			
			var maxScore : Number = (pointsMax * timeMax) + timeMax; 
			var playerScore : Number = (pointsValue * timeMax) + timeValue;
			objeto_scorm["lessonScore"]["raw"] = (playerScore / maxScore) * objeto_scorm["lessonScore"]["max"];
			SaveScorm();
		}
		
		public function SetFailed() : void 
		{
			if (lessonLocation["failed"] == null) lessonLocation["failed"] = 0;
			var newScorm : Object = new Object();
			newScorm["lessonStatus"] = objeto_scorm["lessonStatus"];
			newScorm["lessonScore"] = objeto_scorm["lessonScore"];
			newScorm["lessonLocation"] = new Object();
			newScorm["lessonLocation"]["failed"] = lessonLocation["failed"] + 1;
			objeto_scorm = newScorm;
			SaveScorm();
		}
		
		public function SaveScorm() : void 
		{
			trace(JSON.encode(objeto_scorm));
			if (_offline) return;
			ExternalInterface.call("LMSSetValue", "eguru.games.scorm_data", objeto_scorm);
		}

		public function LoadScorm() : void 
		{
			if (_offline) return;
			objeto_scorm = ExternalInterface.call("LMSGetValue", "eguru.games.scorm_data");
			objeto_scorm["lessonStatus"]["status"] = STATUS_INCOMPLETE;
		}

		public function SaveStates(machineSystem : IStateSystem) : void 
		{
			var states : Array = GetStateSaveArray(machineSystem);
			lessonLocation["states"] = states;
			SaveScorm();
		}
		
		private function GetStateSaveArray(machineSystem : IStateContainer) : Array
		{
			var states : Array = new Array();
			if (machineSystem is CustomComplexState && CustomComplexState(machineSystem).currentState != null && CustomComplexState(machineSystem).saveStatusInScorm) states.push([CustomComplexState(machineSystem).type, CustomComplexState(machineSystem).currentState.type]);
			for each (var state : IState in machineSystem.states) 
			{
				if (state is IStateContainer)
				{
					var childStates : Array = GetStateSaveArray(IStateContainer(state));
					for each (var saveItem : Object in childStates) {
						states.push(saveItem);
					}
				}
			}
			return states;
		}

		public function LoadStates(machineSystem : IStateSystem) : void 
		{
			
			if (lessonLocation["states"] == null) return;			
			LoadStateInMachine(machineSystem, lessonLocation["states"]);
			trace("States Loaded");
		}

		private function LoadStateInMachine(machineSystem : IStateContainer, states : Array) : void 
		{
			if (machineSystem is IStateSystem)
			{
				for each (var saveItem : Array in states) 
				{
					if (IStateSystem(machineSystem).type == saveItem[0])
					{
						trace("Transitioning [State: " + IStateSystem(machineSystem).type + "] to [State: " + saveItem[1] + "]");
						if (IStateSystem(machineSystem).ContainStateWithName(saveItem[1])) 
						{
							if (IStateSystem(machineSystem).currentState != null && IStateSystem(machineSystem).currentState.type == saveItem[1]) break;
							IStateSystem(machineSystem).TransitionToState(saveItem[1]);
						}
						else
						{
							trace("Machine does not contains the state: " + saveItem[1]);
						}
						break;
					}
				}
			}
			
			
			for each (var state : IState in machineSystem.states) 
			{
				if (state is IStateContainer)
				{
					LoadStateInMachine(IStateContainer(state), states);
				}
			}
		}

		public function SaveAnswers(answers : Vector.<QuizAnswerVO>) : void 
		{
			var allAnswers : Array = new Array();
			
			for each (var answer : QuizAnswerVO in answers) 
			{
				//Saves the question
				var answerArray : Array = [null, null, null];
				answerArray[0] = answer.question.id;
				
				//Saves the first alternatives order
				var alternativesOrderArray : Array = new Array();
				for each (var alt : QuizAlternativeVO in answer.alternativesOrder) 
				{
					alternativesOrderArray.push(alt.id);
				}
				answerArray[1] = alternativesOrderArray.length > 0 ? alternativesOrderArray : null;
				
				//Saves the second alternatives order
				var alternativesOrderArray2 : Array = new Array();
				for each (var alt2 : QuizAlternativeVO in answer.alternativesOrder2) 
				{
					alternativesOrderArray2.push(alt2.id);
				}
				answerArray[2] = alternativesOrderArray2.length > 0 ? alternativesOrderArray2 : null;
				allAnswers.push(answerArray);
			}
			
			suspendData["answers"] = allAnswers;
		}

		public function LoadAnswers(quizModel : IQuizModel) : Vector.<QuizAnswerVO> 
		{
			if (suspendData["answers"] == null) suspendData["answers"] = new Array();
			
			var finalList : Vector.<QuizAnswerVO> = new Vector.<QuizAnswerVO>();
			
			for each (var answerArray : Array in suspendData["answers"]) 
			{
				var question : QuizQuestionVO = quizModel.GetQuestionById(answerArray[0]);
				var alternativesOrder : Vector.<QuizAlternativeVO> = question.GetAlternativesOrderByIds(answerArray[1]);
				var alternativesOrder2 : Vector.<QuizAlternativeVO> = question.GetAlternativesOrderByIds(answerArray[2]);
				var newAnswer : QuizAnswerVO = new QuizAnswerVO(question, alternativesOrder, alternativesOrder2);
				finalList.push(newAnswer);
			}
			
			return finalList;
		}
		
		public function SaveCurrentQuestion(currentQuestion : QuizQuestionVO) : void 
		{
			if (currentQuestion == null)
			{
				suspendData["currentQuestion"] = null;
				return;
			}
			suspendData["currentQuestion"] = currentQuestion.id;
			SaveScorm();
		}

		public function LoadCurrentQuestion(quizModel : IQuizModel) : QuizQuestionVO
		{
			if (suspendData["currentQuestion"] == null) return null;			
			return quizModel.GetQuestionById(suspendData["currentQuestion"]);
		}

		public function SaveVariable(numVar : NumberVariableVO) : void 
		{
			var varsArray : Array = suspendData["vars"] == null ? new Array() : suspendData["vars"];
			
			for (var i : int = 0; i < varsArray.length; i++) 
			{
				if (varsArray[i][0] == numVar.name)
				{
					varsArray[i][1] = numVar.value;
					suspendData["vars"] = varsArray;
					
					if (numVar.name == "Points")
					{
						objeto_scorm["lessonScore"]["raw"] = numVar.value / numVar.max * objeto_scorm["lessonScore"]["max"];
					}
					return; 
				}
			}
			
			varsArray.push([numVar.name, numVar.value]);
			suspendData["vars"] = varsArray;
		}

		public function LoadVariable(numVar : NumberVariableVO) : Boolean 
		{
			if (suspendData["vars"] == null) suspendData["vars"] = new Array();
			
			for each (var variable : Array in suspendData["vars"]) 
			{
				if (variable[0] == numVar.name)
				{
					numVar.SetValue(variable[1]);
					return true; 
				}
			}
			return false;
		}
		
		public function SaveTimer(timer : TimerVO) : void 
		{
			if (suspendData["timers"] == null) suspendData["timers"] = new Array();
			for each (var timerArray : Array in suspendData["timers"]) 
			{
				if (timerArray[0] == timer.name)
				{
					timerArray[1] == timer.status;
					return; 
				}
			}
			(suspendData["timers"] as Array).push([timer.name, timer.status]);
		}

		public function LoadTimer(timer : TimerVO) : Boolean 
		{
			if (suspendData["timers"] == null) suspendData["timers"] = new Array();
			
			for each (var timerArray : Array in suspendData["timers"])
			{
				if (timerArray[0] == timer.name)
				{
					timer.SetStatus(timerArray[1]);
					return true; 
				}
			}
			return false;
		}
		
		public function get lessonLocation() : Object
		{
			if (objeto_scorm["lessonLocation"] == null) objeto_scorm["lessonLocation"] = new Object();
			return objeto_scorm["lessonLocation"];
		}

		public function get suspendData() : Object
		{
			if (objeto_scorm["suspendData"] == null) objeto_scorm["suspendData"] = new Object();
			return objeto_scorm["suspendData"];
		}

		public function LoadStudentLevel() : int 
		{
			return objeto_scorm["lessonStatus"]["studentLevel"];
		}

		
	}
}
