package com.eguru.faje.mvcs.models {
	import com.eguru.faje.mvcs.models.data.fsm.core.ICustomState;
	import org.osflash.signals.ISignal;
	import com.eguru.faje.fsm.transition.IStateTransition;
	import com.eguru.faje.fsm.core.IState;
	/**
	 * @author Bruno Tachinardi
	 */
	public interface IStateMachineModel
	{
		function get currentState() : IState;
		function get currentTransition() : IStateTransition;
		function get defaultState() : IState;
		function SetDefaultState(state : IState) : IState;		
		function CancelTransition() : Boolean;
		function ResetToDefault() : IState;
		function get toBeTransitioned() : ISignal;
		function get transitioned() : ISignal;	
		function AddState(state : IState) : IState;
		function AddRawStatesGroup(statesArray : Array) : Vector.<ICustomState>;
		function RemoveState(state : IState) : IState;
		function ContainState(state : IState) : Boolean;
		function Start() : void;
	}
}
