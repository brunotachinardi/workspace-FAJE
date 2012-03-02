package com.eguru.faje.mvcs.models.data.components.quiz {
	import com.eguru.faje.mvcs.models.IAppNumberVariableModel;
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.adobe.serialization.json.JSON;
	import com.eguru.faje.mvcs.models.data.components.ButtonComponentVO;
	import com.eguru.faje.mvcs.models.data.components.TextBoxComponentVO;
	import com.eguru.faje.mvcs.models.data.components.GraphicComponentVO;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class BaseQuizComponentVO extends ComponentVO {
		
		protected var _numOfAlternatives : int;
		protected var _background : GraphicComponentVO;
		protected var _title : TextBoxComponentVO;
		protected var _confirmButton : ButtonComponentVO;
		protected var _pointsBox : TextBoxComponentVO;
		protected var _openTipButton : ButtonComponentVO;
		protected var _closeTipButton : ButtonComponentVO;
		protected var _tipBox : TextBoxComponentVO;
		protected var _tipMax: int;
		protected var _varsModel : IAppNumberVariableModel;
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) :void
		{
			super.Initialize(specifications, models);
			_varsModel = models.varsModel;
			_numOfAlternatives = 3;
			_tipMax = 0;
			if (specifications.hasOwnProperty("numOfAlternatives")) 
			{
				_numOfAlternatives = specifications["numOfAlternatives"];
			}
			
			if (specifications.hasOwnProperty("tipMax"))
			{
				_tipMax = specifications["tipMax"];
			}
			
			//Sets the title text
			_title = new TextBoxComponentVO();

			var titleComponent : TextBoxComponentVO = models.componentsModel.GetComponentByName(specifications["titleText"]) as TextBoxComponentVO;
			var titleSpecification : Object = CloneSpecification(titleComponent.rawSpecification);		

			titleSpecification["name"] = _name + "::title=TextBoxComponent";
			titleSpecification["text"] = "Title text should appear here";
			titleSpecification["variable"] = GetTitleTextVarName();
			if (specifications.hasOwnProperty("titleTextDisplayProperties")) titleSpecification["defaultDisplayProperties"] = specifications["titleTextDisplayProperties"];
			_title.Initialize(titleSpecification, models);
			AddAssetsNames(titleComponent.assetsNames);
			
			//Sets the background image
			if (specifications.hasOwnProperty("backgroundImage"))
			{
				_background = new GraphicComponentVO();
				var bgComponent : GraphicComponentVO = models.componentsModel.GetComponentByName(specifications["backgroundImage"]) as GraphicComponentVO;
				var bgSpecification : Object = CloneSpecification(bgComponent.rawSpecification);	
				bgSpecification["name"] = _name + "::background=GraphicComponent";		
				if (specifications.hasOwnProperty("backgroundImageDisplayProperties")) bgSpecification["defaultDisplayProperties"] = specifications["backgroundImageDisplayProperties"];
				_background.Initialize(bgSpecification, models);
				AddAssetsNames(bgComponent.assetsNames);
			}
			
			//Sets the confirm button
			if (specifications.hasOwnProperty("confirmButton"))
			{
				_confirmButton = new ButtonComponentVO();
				var confirmComponent : ButtonComponentVO = models.componentsModel.GetComponentByName(specifications["confirmButton"]) as ButtonComponentVO;
				var confirmSpecification : Object = CloneSpecification(confirmComponent.rawSpecification);	
				confirmSpecification["name"] = _name + "::confirm=ButtonComponent";					
				if (specifications.hasOwnProperty("confirmButtonDisplayProperties")) confirmSpecification["defaultDisplayProperties"] = specifications["confirmButtonDisplayProperties"];
				_confirmButton.Initialize(confirmSpecification, models);
				AddAssetsNames(confirmComponent.assetsNames);
			}
			
			//Sets the points text
			if (specifications.hasOwnProperty("pointsText"))
			{
				_pointsBox = new TextBoxComponentVO();
				var pointsTextComponent : TextBoxComponentVO = models.componentsModel.GetComponentByName(specifications["pointsText"]) as TextBoxComponentVO;
				var pointsTextSpecification : Object = CloneSpecification(pointsTextComponent.rawSpecification);	
				pointsTextSpecification["name"] = _name + "::points=TextBoxComponent";		
				pointsTextSpecification["text"] = "88";
				pointsTextSpecification["variable"] = GetPointsTextVarName();
				if (specifications.hasOwnProperty("pointsTextDisplayProperties")) pointsTextSpecification["defaultDisplayProperties"] = specifications["pointsTextDisplayProperties"];
				_pointsBox.Initialize(pointsTextSpecification, models);
				AddAssetsNames(pointsTextComponent.assetsNames);
			}
			
			//Sets the tip text
			if (specifications.hasOwnProperty("tipText"))
			{
				_tipBox = new TextBoxComponentVO();
				var tipTextComponent : TextBoxComponentVO = models.componentsModel.GetComponentByName(specifications["tipText"]) as TextBoxComponentVO;
				var tipTextSpecification : Object = CloneSpecification(tipTextComponent.rawSpecification);	
				tipTextSpecification["name"] = _name + "::tip=TextBoxComponent";		
				tipTextSpecification["text"] = "Tip Text Goes Here";
				tipTextSpecification["variable"] = GetTipTextVarName();
				if (specifications.hasOwnProperty("tipTextDisplayProperties")) tipTextSpecification["defaultDisplayProperties"] = specifications["tipTextDisplayProperties"];
				_tipBox.Initialize(tipTextSpecification, models);
				AddAssetsNames(tipTextComponent.assetsNames);
			}
			
			//Sets the open tip button
			if (specifications.hasOwnProperty("openTipButton"))
			{
				_openTipButton = new ButtonComponentVO();
				var openTipButtonComponent : ButtonComponentVO = models.componentsModel.GetComponentByName(specifications["openTipButton"]) as ButtonComponentVO;
				var openTipButtonSpecification : Object = CloneSpecification(openTipButtonComponent.rawSpecification);	
				openTipButtonSpecification["name"] = _name + "::open_tip=ButtonComponent";		
				if (specifications.hasOwnProperty("openTipButtonDisplayProperties")) openTipButtonSpecification["defaultDisplayProperties"] = specifications["openTipButtonDisplayProperties"];
				_openTipButton.Initialize(openTipButtonSpecification, models);
				AddAssetsNames(openTipButtonComponent.assetsNames);
			}
			
			//Sets the close tip button
			if (specifications.hasOwnProperty("closeTipButton"))
			{
				_closeTipButton = new ButtonComponentVO();
				var closeTipButtonComponent : ButtonComponentVO = models.componentsModel.GetComponentByName(specifications["closeTipButton"]) as ButtonComponentVO;
				var closeTipButtonSpecification : Object = CloneSpecification(closeTipButtonComponent.rawSpecification);	
				closeTipButtonSpecification["name"] = _name + "::close_tip=ButtonComponent";		
				if (specifications.hasOwnProperty("closeTipButtonDisplayProperties")) closeTipButtonSpecification["defaultDisplayProperties"] = specifications["closeTipButtonDisplayProperties"];
				_closeTipButton.Initialize(closeTipButtonSpecification, models);
				AddAssetsNames(closeTipButtonComponent.assetsNames);
			}	
		}

		private function GetTipCountVariableName() : String 
		{
			return _name + "::Tip#";
		}
		
		protected function AddAssetsNames(newNames : Vector.<String>) : void 
		{
			for each (var assetName : String in newNames) 
			{
				assetsNames.push(assetName);	
			}
		}

		protected function CloneSpecification(specification : Object) : Object 
		{
			return JSON.decode(JSON.encode(specification));
		}
		
		public function GetTitleTextVarName() : String
		{
			return _name + "::title_variable";
		}
		
		public function GetPointsTextVarName() : String
		{
			return _name + "::points_variable";
		}
		
		public function GetTipTextVarName() : String
		{
			return _name + "::tip_variable";
		}
		
		public function GetConfirmClickMessage() : String
		{
			return _name + "::confirm_click_message";
		}
		
		public function get title() : TextBoxComponentVO
		{
			return _title;
		}
		
		public function get background() : GraphicComponentVO
		{
			return _background;
		}
		
		public function get numOfAlternatives() : int
		{
			return _numOfAlternatives;
		}
		
		public function get tipBox() : TextBoxComponentVO
		{
			return _tipBox;
		}
		
		public function get openTipButton() : ButtonComponentVO
		{
			return _openTipButton;
		}
		
		public function get closeTipButton() : ButtonComponentVO
		{
			return _closeTipButton;
		}
		
		public function get tipMax() : int
		{
			return _tipMax;
		}
		
		public function get currentTipCount() : int
		{
			return _varsModel.GetVariableValue(GetTipCountVariableName());
		}
		
		public function get pointsBox() : TextBoxComponentVO
		{
			return _pointsBox;
		}
		
		public function get confirmButton() : ButtonComponentVO
		{
			return _confirmButton;
		}
		
		public function CanGetTip() : Boolean
		{
			if (_tipMax == 0) 
			{
				return true;
			}

			if (currentTipCount < _tipMax) 
			{
				return true;
			}
			
			return false;
		}
		
		public function GetTip() : void
		{
			_varsModel.AddToVariable(GetTipCountVariableName(), 1);
		}
	}
}
