package com.eguru.faje.mvcs.models.data.components.quiz 
{
	import com.eguru.faje.mvcs.models.SoundModel;
	import com.eguru.faje.mvcs.models.data.components.GraphicComponentVO;
	import flash.geom.Point;
	import com.eguru.faje.mvcs.models.data.components.ButtonComponentVO;
	import com.eguru.faje.mvcs.models.data.DisplayPropertiesVO;
	import com.eguru.faje.utils.geom.Grid2D;
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.eguru.faje.mvcs.models.data.components.quiz.BaseQuizComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ConnectQuizVO extends BaseQuizComponentVO 
	{
		
		protected var _firstTextAlternatives : Vector.<ButtonComponentVO>;
		protected var _secondTextAlternatives : Vector.<ButtonComponentVO>;
		
		protected var _firstConnectAlternativesText : Vector.<ButtonComponentVO>;
		protected var _secondConnectAlternativesText : Vector.<ButtonComponentVO>;
		
		protected var _firstTextBackgroundImage : GraphicComponentVO;
		protected var _secondTextBackgroundImage : GraphicComponentVO;
		
		protected var _firstImageBackgroundImage : GraphicComponentVO;
		
		protected var _models : SpecificationsModelsVO;
		protected var _firstImageConnectOffsetX : Number;
		protected var _firstImageConnectOffsetY : Number;
		
		protected var _drag : Boolean;
		protected var _connectSound : String;
		protected var _connectSoundLayer : String;
		
		protected var _buttonNormalSound : String;
		protected var _buttonOverSound : String;
		protected var _buttonPressedSound : String;
		protected var _buttonActiveNormalSound : String;
		protected var _buttonActiveOverSound : String;
		protected var _buttonActivePressedSound : String;
		
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) :void
		{
			super.Initialize(specifications, models);
			
			_models = models;

			_connectSound = null;
			if (specifications.hasOwnProperty("connectSound"))
			{
				_connectSound = specifications["connectSound"];
			}
			
			_connectSoundLayer = SoundModel.INTERFACE_FX_SOUND_NAME;
			if (specifications.hasOwnProperty("connectSoundLayer"))
			{
				_connectSoundLayer = specifications["connectSoundLayer"];
			}

			//Prepares alternatives grid specifications
			var firstGridX : Number = 0;
			if (specifications.hasOwnProperty("firstGridX"))
			{
				firstGridX = specifications["firstGridX"];
			}
			
			var firstGridY : Number = 0;
			if (specifications.hasOwnProperty("firstGridY"))
			{
				firstGridY = specifications["firstGridY"];
			}
			
			var secondGridX : Number = 0;
			if (specifications.hasOwnProperty("secondGridX"))
			{
				secondGridX = specifications["secondGridX"];
			}
			
			var secondGridY : Number = 0;
			if (specifications.hasOwnProperty("secondGridY"))
			{
				secondGridY = specifications["secondGridY"];
			}
			
			var textGridXDistance : Number = 50;
			if (specifications.hasOwnProperty("textGridXDistance"))
			{
				textGridXDistance = specifications["textGridXDistance"];
			}
			
			var textGridYDistance : Number = 50;
			if (specifications.hasOwnProperty("textGridYDistance"))
			{
				textGridYDistance = specifications["textGridYDistance"];
			}
			
			var imageGridXDistance : Number = 50;
			if (specifications.hasOwnProperty("imageGridXDistance"))
			{
				imageGridXDistance = specifications["imageGridXDistance"];
			}
			
			var imageGridYDistance : Number = 50;
			if (specifications.hasOwnProperty("imageGridYDistance"))
			{
				imageGridYDistance = specifications["imageGridYDistance"];
			}
			
			var gridMaxCollumns : int = 1;
			if (specifications.hasOwnProperty("gridMaxCollumns"))
			{
				gridMaxCollumns = specifications["gridMaxCollumns"];
			}

			_drag = false;
			if (specifications.hasOwnProperty("drag"))
			{
				_drag = specifications["drag"];
			}
			
			
			//Creates the alternatives grid
			var firstTextGrid : Grid2D = new Grid2D(gridMaxCollumns, textGridXDistance, textGridYDistance, firstGridX, firstGridY);
			var secondTextGrid : Grid2D = new Grid2D(gridMaxCollumns, textGridXDistance, textGridYDistance, secondGridX, secondGridY);
			var firstImageGrid : Grid2D = new Grid2D(gridMaxCollumns, imageGridXDistance, imageGridYDistance, firstGridX, firstGridY);
			var secondImageGrid : Grid2D = new Grid2D(gridMaxCollumns, imageGridXDistance, imageGridYDistance, secondGridX, secondGridY);
			
			//Gets the base component
			var textComponent : ButtonComponentVO = models.componentsModel.GetComponentByName(specifications["textButton"]) as ButtonComponentVO;
			
			_buttonNormalSound = textComponent.normalSound;
			_buttonOverSound = textComponent.overSound;
			_buttonPressedSound = textComponent.pressedSound;
			_buttonActiveNormalSound = textComponent.activeNormalSound;
			_buttonActiveOverSound = textComponent.activeOverSound;
			_buttonActivePressedSound = textComponent.activePressedSound;
			
			//Gets the base display properties
			var alternativesDisplayProperties : DisplayPropertiesVO = specifications.hasOwnProperty("textButtonDisplayProperties") ? 
							models.displayModel.GetDisplayPropertyByName(specifications["textButtonDisplayProperties"]) : 
							models.displayModel.GetDisplayPropertyByName(textComponent.rawSpecification["defaultDisplayProperties"]);
							
			//Creates the text components
			_firstTextAlternatives = GenerateTextComponents(1, firstTextGrid, textComponent, alternativesDisplayProperties, models);
			_secondTextAlternatives = GenerateTextComponents(2, secondTextGrid, textComponent, alternativesDisplayProperties, models);
			
			RegisterImageButtonsDisplayProperties(firstImageGrid, 1);
			RegisterImageButtonsDisplayProperties(secondImageGrid, 2);
			
			//Creates the image components
			//_firstImageAlternatives = GenerateImageComponents(1, firstImageGrid, textComponent, alternativesDisplayProperties, models);
			//_secondImageAlternatives = GenerateImageComponents(2, secondImageGrid, textComponent, alternativesDisplayProperties, models);
			
			//Gets the base component
			var connectTextComponent : ButtonComponentVO = models.componentsModel.GetComponentByName(specifications["connectButton"]) as ButtonComponentVO;
			
			//Gets the base display properties
			var connectDisplayProperties : DisplayPropertiesVO = 
							models.displayModel.GetDisplayPropertyByName(connectTextComponent.rawSpecification["defaultDisplayProperties"]);
			
			//Sets the first connect group
			var firstConnectOffsetX : Number = 50;
			if (specifications.hasOwnProperty("firstConnectOffsetX"))
			{
				firstConnectOffsetX = specifications["firstConnectOffsetX"];
			}
			
			var firstConnectOffsetY : Number = 50;
			if (specifications.hasOwnProperty("firstConnectOffsetY"))
			{
				firstConnectOffsetY = specifications["firstConnectOffsetY"];
			}
			
			firstTextGrid.Clear();
			_firstConnectAlternativesText = GenerateConnectTextComponents(1, firstTextGrid, connectTextComponent, connectDisplayProperties, models, firstConnectOffsetX, firstConnectOffsetY);
			
			//Sets the second connect group
			var secondConnectOffsetX : Number = 50;
			if (specifications.hasOwnProperty("secondConnectOffsetX"))
			{
				secondConnectOffsetX = specifications["secondConnectOffsetX"];
			}
			
			var secondConnectOffsetY : Number = 50;
			if (specifications.hasOwnProperty("secondConnectOffsetY"))
			{
				secondConnectOffsetY = specifications["secondConnectOffsetY"];
			}
			
			secondTextGrid.Clear();
			_secondConnectAlternativesText = GenerateConnectTextComponents(2, secondTextGrid, connectTextComponent, connectDisplayProperties, models, secondConnectOffsetX, secondConnectOffsetY);
			
			//Sets the first image connect group
			_firstImageConnectOffsetX = 50;
			if (specifications.hasOwnProperty("firstImageConnectOffsetX"))
			{
				_firstImageConnectOffsetX = specifications["firstImageConnectOffsetX"];
			}
			
			_firstImageConnectOffsetY = 50;
			if (specifications.hasOwnProperty("firstImageConnectOffsetY"))
			{
				_firstImageConnectOffsetY = specifications["firstImageConnectOffsetY"];
			}
			
			//Sets the text background image
			if (specifications.hasOwnProperty("textGroupBackgroundImage"))
			{
				var textBackgroundComponent : GraphicComponentVO = models.componentsModel.GetComponentByName(specifications["textGroupBackgroundImage"]) as GraphicComponentVO;	
				var textBackgroundDisplayProperties : DisplayPropertiesVO = 
							models.displayModel.GetDisplayPropertyByName(textBackgroundComponent.rawSpecification["defaultDisplayProperties"]);
							
				_firstTextBackgroundImage = new GraphicComponentVO();
				_firstTextBackgroundImage.Initialize(GenerateBackgroundSpecification(textBackgroundComponent, textBackgroundDisplayProperties, models, firstGridX, firstGridY, "FirstGroup"), models);
				
				_secondTextBackgroundImage = new GraphicComponentVO();
				_secondTextBackgroundImage.Initialize(GenerateBackgroundSpecification(textBackgroundComponent, textBackgroundDisplayProperties, models, secondGridX, secondGridY, "SecondGroup"), models);
				
			}
			
			//Sets the image background image
			if (specifications.hasOwnProperty("imageGroupBackgroundImage"))
			{
				var imageBackgroundComponent : GraphicComponentVO = models.componentsModel.GetComponentByName(specifications["imageGroupBackgroundImage"]) as GraphicComponentVO;	
				var imageBackgroundDisplayProperties : DisplayPropertiesVO = 
							models.displayModel.GetDisplayPropertyByName(imageBackgroundComponent.rawSpecification["defaultDisplayProperties"]);
				
				_firstImageBackgroundImage = new GraphicComponentVO();
				_firstImageBackgroundImage.Initialize(GenerateBackgroundSpecification(imageBackgroundComponent, imageBackgroundDisplayProperties, models, firstGridX, firstGridY, "FirstImageGroup"), models);
					
			}
		}
		
		private function RegisterImageButtonsDisplayProperties(grid : Grid2D, number : int) : void
		{
			for (var i : int = 0; i < _numOfAlternatives; i++) 
			{			
				//Gets the component position in the grid and sets its display properties acordingly
				var position : Point = grid.GetNextPos();
				var displayPropertiesSpec : Object = new Object();
				displayPropertiesSpec["name"] = GetAlternativeDisplayPropertiesNameByIndex(i, number, false);
				displayPropertiesSpec["x"] = position.x;
				displayPropertiesSpec["y"] = position.y;
				
				//Makes the new display properties avaiable
				_models.displayModel.AddDisplayProperty(new DisplayPropertiesVO(displayPropertiesSpec));
			}
		}

		private function GenerateConnectTextComponents(number : int, grid : Grid2D, connectTextComponent : ButtonComponentVO, connectDisplayProperties : DisplayPropertiesVO, models : SpecificationsModelsVO, offsetX : Number, offsetY : Number) : Vector.<ButtonComponentVO> 
		{
			var resultList : Vector.<ButtonComponentVO> = new Vector.<ButtonComponentVO>();
			for (var i : int = 0; i < _numOfAlternatives; i++) 
			{
				//Creates the new alternative component
				var newConnect : ButtonComponentVO = new ButtonComponentVO();
				
				//Gets the component position in the grid and sets its display properties acordingly
				var position : Point = grid.GetNextPos();
				var displayPropertiesSpec : Object = CloneSpecification(connectDisplayProperties.rawSpecification);
				displayPropertiesSpec["name"] = GetAlternativeDisplayPropertiesNameByIndex(i, number, true) + "::connect";
				displayPropertiesSpec["x"] = position.x + offsetX;
				displayPropertiesSpec["y"] = position.y + offsetY;
				
				//Duplicates and customizes the alernative specifications
				var alternativeSpec : Object = CloneSpecification(connectTextComponent.rawSpecification);
				alternativeSpec["name"] = GetAlternativeConnectNameByIndex(i, number, true);
				alternativeSpec["defaultDisplayProperties"] = displayPropertiesSpec["name"];
				alternativeSpec["variable"] = GetAlternativeConnectTextVarName(i, number, true);
				alternativeSpec["text"] = "";
				
				//Makes the new display properties avaiable
				models.displayModel.AddDisplayProperty(new DisplayPropertiesVO(displayPropertiesSpec));
				
				//Initializes the component
				newConnect.Initialize(alternativeSpec, models);
				
				//Adds it to the alternatives list
				resultList.push(newConnect);
			}
			AddAssetsNames(connectTextComponent.assetsNames);
			return resultList;
		}

		

		private function GenerateBackgroundSpecification(component : GraphicComponentVO, alternativesDisplayProperties : DisplayPropertiesVO, models : SpecificationsModelsVO, posX : Number, posY : Number, name : String) : Object 
		{
			var specification : Object = CloneSpecification(component.rawSpecification);	
			specification["name"] = _name + "::background=GraphicComponent::" + name;
			
			var displayPropertiesSpec : Object = CloneSpecification(alternativesDisplayProperties.rawSpecification);
			displayPropertiesSpec["name"] = _name + "::background=GraphicComponent::DisplayProperty::" + name;
			displayPropertiesSpec["x"] += posX;
			displayPropertiesSpec["y"] += posY;
			
			//Makes the new display properties avaiable
			models.displayModel.AddDisplayProperty(new DisplayPropertiesVO(displayPropertiesSpec));
			
			specification["defaultDisplayProperties"] = displayPropertiesSpec["name"];
			
			AddAssetsNames(component.assetsNames);
			return specification;
		}

		private function GenerateTextComponents(number : int, grid : Grid2D, alternativesComponent : ButtonComponentVO, alternativesDisplayProperties : DisplayPropertiesVO, models : SpecificationsModelsVO) : Vector.<ButtonComponentVO> 
		{
			var resultList : Vector.<ButtonComponentVO> = new Vector.<ButtonComponentVO>();
			for (var i : int = 0; i < _numOfAlternatives; i++) 
			{
				//Creates the new alternative component
				var newAlternative : ButtonComponentVO = new ButtonComponentVO();
				
				//Gets the component position in the grid and sets its display properties acordingly
				var position : Point = grid.GetNextPos();
				var displayPropertiesSpec : Object = CloneSpecification(alternativesDisplayProperties.rawSpecification);
				displayPropertiesSpec["name"] = GetAlternativeDisplayPropertiesNameByIndex(i, number, true);
				displayPropertiesSpec["x"] = position.x;
				displayPropertiesSpec["y"] = position.y;
				
				//Duplicates and customizes the alernative specifications
				var alternativeSpec : Object = CloneSpecification(alternativesComponent.rawSpecification);
				alternativeSpec["name"] = GetAlternativeNameByIndex(i, number, true);
				alternativeSpec["defaultDisplayProperties"] = displayPropertiesSpec["name"];
				alternativeSpec["variable"] = GetAlternativeTextVarName(i, number, true);
				alternativeSpec["message"] = GetAlternativeClickMessage(i, number, true);
				alternativeSpec["text"] = "Alternative number " + (i + 1) + " text!";
				
				//Makes the new display properties avaiable
				models.displayModel.AddDisplayProperty(new DisplayPropertiesVO(displayPropertiesSpec));
				
				//Initializes the component
				newAlternative.Initialize(alternativeSpec, models);
				
				//Adds it to the alternatives list
				resultList.push(newAlternative);
			}
			AddAssetsNames(alternativesComponent.assetsNames);
			return resultList;
		}
		
		public function GenerateImageButtonSpec(imageName : String, index : int, number : int) : ButtonComponentVO
		{
			var spec : Object = 
			{
				name: GetAlternativeNameByIndex(index, number, false),
                normal: imageName,
				defaultDisplayProperties : GetAlternativeDisplayPropertiesNameByIndex(index, number, false),
				normalSound : _buttonNormalSound,
				overSound : _buttonOverSound,
				pressedSound : _buttonPressedSound,
				activeNormalSound : _buttonActiveNormalSound,
				activeOverSound : _buttonActiveOverSound,
				activePressedSound : _buttonActivePressedSound
			};
			
			var component : ButtonComponentVO = new ButtonComponentVO();
			component.Initialize(spec, _models);
			return component;
		}
		
		public function GetAlternativeTextVarName(index : int, number : int, isText : Boolean) : String
		{
			return _name + "::alternative_variable::index=" + index + "::group=" + number + "::type=" + (isText ? "text" : "image");
		}
		
		public function GetAlternativeConnectTextVarName(index : int, number : int, isText : Boolean) : String 
		{
			return _name + "::alternative_variable::index=" + index + "::group=" + number + "::type=" + (isText ? "text" : "image") + "::connect";
		}
		
		public function GetAlternativeClickMessage(index : int, number : int, isText : Boolean) : String
		{
			return _name + "::alternative_click_message::index=" + index + "::group=" + number + "::type=" + (isText ? "text" : "image");
		}
		
		public function GetAlternativeDisplayPropertiesNameByIndex(i : int, number : int, isText : Boolean) : String
		{
			return _name + "::alternative_button_dp::index=" + i + "::group=" + number + "::type=" + (isText ? "text" : "image");
		}
		
		public function GetAlternativeNameByIndex(i : int, number : int, isText : Boolean) : String
		{
			return _name + "::alternative_button::index=" + i + "::group=" + number + "::type=" + (isText ? "text" : "image");
		}
		
		public function GetAlternativeConnectNameByIndex(i : int, number : int, isText : Boolean) : String 
		{
			return _name + "::alternative_button::index=" + i + "::group=" + number + "::type=" + (isText ? "text" : "image" + "::connect");
		}
		
		public function get firstAlternatives() : Vector.<ButtonComponentVO> 
		{
			return _firstTextAlternatives;
		}
		
		public function get secondAlternatives() : Vector.<ButtonComponentVO> 
		{
			return _secondTextAlternatives;
		}
		
		public function get firstConnectAlternativesText() : Vector.<ButtonComponentVO> 
		{
			return _firstConnectAlternativesText;
		}
		
		public function get secondConnectAlternativesText() : Vector.<ButtonComponentVO> 
		{
			return _secondConnectAlternativesText;
		}
		
		public function get firstTextBackgroundImage() : GraphicComponentVO
		{
			return _firstTextBackgroundImage;
		}
		
		public function get secondTextBackgroundImage() : GraphicComponentVO
		{
			return _secondTextBackgroundImage;
		}
		
		public function get firstImageBackgroundImage() : GraphicComponentVO
		{
			return _firstImageBackgroundImage;
		}
		
		public function get firstImageConnectOffsetX() : Number
		{
			return _firstImageConnectOffsetX;
		}
		
		public function get firstImageConnectOffsetY() : Number
		{
			return _firstImageConnectOffsetY;
		}
		
		public function get drag() : Boolean
		{
			return _drag;
		}
		
		public function get connectSound() : String
		{
			return _connectSound;
		}
		
		public function get connectSoundLayer() : String
		{
			return _connectSoundLayer;
		}
	}
}
