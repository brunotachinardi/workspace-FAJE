package com.eguru.faje.mvcs.models.data.components {
	import com.eguru.faje.mvcs.models.data.SpecificationsModelsVO;
	import com.eguru.faje.mvcs.models.data.components.GraphicComponentVO;

	/**
	 * @author Bruno Tachinardi
	 */
	public class AnimationComponentVO extends GraphicComponentVO {
		
		public static const DEFAULT_ANIMATION_NAME : String = "main_animation";
		public static const ANIMATION_END_EVENT_DEFAULT : String = "animation_end";
		public static const DEFAULT_LOOP : Boolean = false;
		public static const DEFAULT_FPS : Number = 24;
		
		protected var _endEvent : String;
		protected var _animationName : String;
		protected var _loop : Boolean;
		protected var _fps : Number;
		protected var _sounds : Vector.<AnimationSoundVO>;
		
		override public function Initialize(specifications : Object, models : SpecificationsModelsVO) :void
		{
			super.Initialize(specifications, models);
			
			_endEvent = ANIMATION_END_EVENT_DEFAULT;
			if (specifications.hasOwnProperty("end"))
			{
				_endEvent = specifications["end"];
			}
			
			_animationName = DEFAULT_ANIMATION_NAME;
			if (specifications.hasOwnProperty("animationName"))
			{
				_animationName = specifications["animationName"];
			}
			
			_loop = DEFAULT_LOOP;
			if (specifications.hasOwnProperty("loop"))
			{
				_loop = specifications["loop"];
			}
			
			_fps = 	DEFAULT_FPS;
			if (specifications.hasOwnProperty("fps"))
			{
				_fps = specifications["fps"];
			}
			
			_sounds = new Vector.<AnimationSoundVO>();
			if (specifications.hasOwnProperty("sounds"))
			{
				for each (var spec : Object in specifications["sounds"]) 
				{
					_sounds.push(new AnimationSoundVO(spec, models));
				}
			}
			
			assetsNames.push(_imageName);
		}
		
		public function get animationName() : String
		{
			return _animationName;
		}
		
		public function get endEvent() : String
		{
			return _endEvent;
		}
		
		public function get loop() : Boolean
		{
			return _loop;
		}
		
		public function get fps() : Number
		{
			return _fps;
		}
		
		public function get sounds() : Vector.<AnimationSoundVO>
		{
			return _sounds;
		}
	}
}
