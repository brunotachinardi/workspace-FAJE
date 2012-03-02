package com.eguru.faje.mvcs.models.data.components.quiz 
{
	import com.eguru.faje.mvcs.models.data.components.ButtonComponentVO;
	import com.eguru.faje.mvcs.models.data.DisplayPropertiesVO;
	import flash.geom.Point;
	import com.eguru.faje.utils.geom.Grid2D;
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class MultiAlternativeQuizComponentVO extends BaseQuizComponentVO
	{
		
		protected var _alternatives : Vector.<ButtonComponentVO>;
		protected var _selectedIndex : int;
		
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) :void
		{
			super.Initialize(specifications, models);
			_selectedIndex = -1;
			
			//Prepares alternatives grid specifications
			var gridX : Number = 0;
			if (specifications.hasOwnProperty("alternativesGridX"))
			{
				gridX = specifications["alternativesGridX"];
			}
			
			var gridY : Number = 0;
			if (specifications.hasOwnProperty("alternativesGridY"))
			{
				gridY = specifications["alternativesGridY"];
			}
			
			var gridXDistance : Number = 90;
			if (specifications.hasOwnProperty("alternativesGridXDistance"))
			{
				gridXDistance = specifications["alternativesGridXDistance"];
			}
			
			var gridYDistance : Number = 90;
			if (specifications.hasOwnProperty("alternativesGridYDistance"))
			{
				gridYDistance = specifications["alternativesGridYDistance"];
			}
			
			var gridMaxCollumns : int = 1;
			if (specifications.hasOwnProperty("alternativesGridMaxCollumns"))
			{
				gridMaxCollumns = specifications["alternativesGridMaxCollumns"];
			}
			
			
			//Creates the alternatives grid
			var grid : Grid2D = new Grid2D(gridMaxCollumns, gridXDistance, gridYDistance, gridX, gridY);
			
			//Gets the base component
			var alternativesComponent : ButtonComponentVO = models.componentsModel.GetComponentByName(specifications["alternativeButton"]) as ButtonComponentVO;
			
			//Gets the base display properties
			var alternativesDisplayProperties : DisplayPropertiesVO = specifications.hasOwnProperty("alternativeButtonDisplayProperties") ? 
							models.displayModel.GetDisplayPropertyByName(specifications["alternativeButtonDisplayProperties"]) : 
							models.displayModel.GetDisplayPropertyByName(alternativesComponent.rawSpecification["defaultDisplayProperties"]);
							
			//Creates all the alternatives components
			_alternatives = new Vector.<ButtonComponentVO>();
			
			for (var i : int = 0; i < _numOfAlternatives; i++) 
			{
				//Creates the new alternative component
				var newAlternative : ButtonComponentVO = new ButtonComponentVO();
				
				//Gets the component position in the grid and sets its display properties acordingly
				var position : Point = grid.GetNextPos();
				var displayPropertiesSpec : Object = CloneSpecification(alternativesDisplayProperties.rawSpecification);
				displayPropertiesSpec["name"] = GetAlternativeDisplayPropertiesNameByIndex(i);
				displayPropertiesSpec["x"] = position.x;
				displayPropertiesSpec["y"] = position.y;
				
				//Duplicates and customizes the alternative specifications
				var alternativeSpec : Object = CloneSpecification(alternativesComponent.rawSpecification);
				alternativeSpec["name"] = GetAlternativeNameByIndex(i);
				alternativeSpec["defaultDisplayProperties"] = displayPropertiesSpec["name"];
				alternativeSpec["variable"] = GetAlternativeTextVarName(i);
				alternativeSpec["message"] = GetAlternativeClickMessage(i);
				alternativeSpec["text"] = "Alternative number " + (i + 1) + " text!";
				
				//Makes the new display properties avaiable
				models.displayModel.AddDisplayProperty(new DisplayPropertiesVO(displayPropertiesSpec));
				
				//Initializes the component
				newAlternative.Initialize(alternativeSpec, models);
				
				//Adds it to the alternatives list
				_alternatives.push(newAlternative);
			}
			AddAssetsNames(alternativesComponent.assetsNames);
			
		}
		
		public function GetAlternativeTextVarName(index : int) : String
		{
			return _name + "::alternative_variable::index=" + index;
		}
		
		public function GetAlternativeClickMessage(index : int) : String
		{
			return _name + "::alternative_click_message::index=" + index;
		}
		
		public function GetAlternativeDisplayPropertiesNameByIndex(i : int) : String
		{
			return _name + "::alternative_button_dp::index=" + i;
		}
		
		public function GetAlternativeNameByIndex(i : int) : String
		{
			return _name + "::alternative_button::index=" + i;
		}
		
		public function get alternatives() : Vector.<ButtonComponentVO> 
		{
			return _alternatives;
		}
		
	}
}
