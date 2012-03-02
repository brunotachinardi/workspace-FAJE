package com.eguru.faje.fsm.core {

	/**
	 * @author Bruno Tachinardi
	 */
	public class OrthogonalState extends StateContainer {
		
		public var resetOnExit : Boolean;
		public var resetOnEnter : Boolean;
		
		public function OrthogonalState(type : String, resetOnExit : Boolean = false, resetOnEnter : Boolean = false) 
		{
			super(type);
			this.resetOnExit = resetOnExit;
			this.resetOnEnter = resetOnEnter;
		}

		public override function Enter() : void
		{
			super.Enter();
			 for each (var i : IState in _subStates) {
			 	i.Enter();
				if (resetOnEnter && i is IStateSystem)
				{
					var system : IStateSystem = i as IStateSystem;
					system.ResetToDefault();
				}
			 }
		}
		
		public override function Update() : void
		{
			 super.Update();
			 for each (var i : IState in _subStates) {
			 	i.Update();
			 }
		}
		
		public override function Exit() : void
		{
			 super.Exit();
			 for each (var i : IState in _subStates) {
			 	i.Exit();
				if (resetOnExit && i is IStateSystem)
				{
					var system : IStateSystem = i as IStateSystem;
					system.ResetToDefault();
				}
			 }
		}
		
	}
}
