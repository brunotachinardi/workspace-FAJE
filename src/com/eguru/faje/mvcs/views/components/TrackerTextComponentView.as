package com.eguru.faje.mvcs.views.components {
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.views.components.core.TextComponentView;
	import com.eguru.faje.mvcs.models.data.components.TrackerTextComponentVO;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class TrackerTextComponentView extends TextComponentView 
	{
		protected var _trackerVO : TrackerTextComponentVO;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			_defaultTextArgs = {value : 0, total : 1};
			super.Initialize(componentVO, assets);			
			_trackerVO = componentVO as TrackerTextComponentVO;			
			
		}
		
		public function UpdateVariable(vars : IAppNumberVariableModel) : void 
		{
			var currentValue : Number = vars.GetVariableValue(_trackerVO.targetVarName);
			var currentTotal : Number = vars.GetVariableMax(_trackerVO.targetVarName);
			UpdateText({value : currentValue, total:currentTotal});
		}
		
		public function CheckVariableUpdate(name : String, value : Number, total : Number) : void
		{
			if (name != _trackerVO.targetVarName) return;
			UpdateText({value : value, total : total});
		}

		
	}
}
