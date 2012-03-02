package com.eguru.faje.mvcs.views.components.core {
	import flash.media.Sound;
	import com.eguru.faje.utils.sound.core.ISoundObject;
	import flash.display.DisplayObject;
	import com.eguru.faje.mvcs.models.data.DisplayPropertiesVO;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import flash.display.Sprite;

	/**
	 * @author Bruno Tachinardi
	 */
	public class ComponentView extends Sprite {
		
		protected var _componentVO : ComponentVO;
		public var depth : Number;
		public var pivotX : Number;
		public var pivotY : Number;
		public var _savedDisplayProperties : DisplayPropertiesVO;
		public var exiting : Boolean = false;
		protected var _activated : Boolean;
		protected var _childrenList : Vector.<ComponentView> = new Vector.<ComponentView>();
		protected var _assets : IAssetModel;
		
		protected function GetSound(assets : IAssetModel, soundName : String, layerName : String) : ISoundObject 
		{
			return assets.AddSoundInLayer(soundName, assets.GetAssetContentByName(soundName) as Sound, layerName);
		}
		
		protected function PlaySoundOnce(soundName : String, layerName : String) : void 
		{
			PlaySound(soundName, layerName, 0, 1, 1);
		}
		
		protected function PlaySound(soundName : String, layerName : String, startTime : Number = 0, loops : int = 0, volume : Number = 1) : void 
		{
			GetSound(_assets, soundName, layerName).Play(startTime, loops, volume);
		}
		
		protected function FadeSound(soundName : String, layerName : String, volume : Number = 0, fadeLenght : int = 1, stopOnComplete : Boolean = false) : void 
		{
			GetSound(_assets, soundName, layerName).Fade(volume, fadeLenght, stopOnComplete);
		}
		
		public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{	
			_assets = assets;
			_activated = true;	
			_componentVO = componentVO;
			depth = 0;
			pivotX = 0;
			pivotY = 0;
			ApplyProperties();
		}
		
		public function Disactivate() : void
		{
			_activated = false;
			for (var i : int = 0; i < numChildren; i++) 
			{
				var child : DisplayObject = getChildAt(i);
				if (child is ComponentView)
				{
					var compChild : ComponentView = child as ComponentView;
					compChild.Disactivate();
				}
			}
			
			for each (var component : ComponentView in _childrenList) 
			{
				component.Disactivate();
			}
		}
		
		public function Activate() : void
		{
			_activated = true;
			for (var i : int = 0; i < numChildren; i++) 
			{
				var child : DisplayObject = getChildAt(i);
				if (child is ComponentView)
				{
					var compChild : ComponentView = child as ComponentView;
					compChild.Activate();
				}
			}
			
			for each (var component : ComponentView in _childrenList) 
			{
				component.Activate();
			}
		}
		
		public function get vo() : ComponentVO
		{
			return _componentVO;
		}
		
		public function ApplyProperties() : void
		{				
			if (!isNaN(_componentVO.displayProperties.x))
			{
				this.x = _componentVO.displayProperties.x;
			}
			
			if (!isNaN(_componentVO.displayProperties.y))
			{
				this.y = _componentVO.displayProperties.y;
			}
			
			if (!isNaN(_componentVO.displayProperties.width))
			{
				this.width = _componentVO.displayProperties.width;
			}
			
			if (!isNaN(_componentVO.displayProperties.height))
			{
				this.height = _componentVO.displayProperties.height;
			}
			
			if (!isNaN(_componentVO.displayProperties.alpha))
			{
				this.alpha = _componentVO.displayProperties.alpha;
			}
			
			if (!isNaN(_componentVO.displayProperties.rotation))
			{
				this.rotation = _componentVO.displayProperties.rotation;
			}
			
			if (!isNaN(_componentVO.displayProperties.depth))
			{
				this.depth = _componentVO.displayProperties.depth;
			}
			
			if (!isNaN(_componentVO.displayProperties.pivotX))
			{
				this.pivotX = _componentVO.displayProperties.pivotX;
			}
			
			if (!isNaN(_componentVO.displayProperties.pivotY))
			{
				this.pivotY = _componentVO.displayProperties.pivotY;
			}
			
			if (_componentVO.displayProperties.filters != null && _componentVO.displayProperties.filters.length > 0)
			{
				this.filters = _componentVO.displayProperties.filters;
			}
		}

		public function GetTweenProperties() : Object
		{		
			
			var tweenObj : Object = new Object();		
			if (!isNaN(_componentVO.displayProperties.x))
			{
				tweenObj["x"] = _componentVO.displayProperties.x;
			}
			
			if (!isNaN(_componentVO.displayProperties.y))
			{
				tweenObj["y"] = _componentVO.displayProperties.y;
			}
			
			if (!isNaN(_componentVO.displayProperties.width))
			{
				tweenObj["width"] = _componentVO.displayProperties.width;
			}
			
			if (!isNaN(_componentVO.displayProperties.height))
			{
				tweenObj["height"] = _componentVO.displayProperties.height;
			}
			
			if (!isNaN(_componentVO.displayProperties.alpha))
			{
				tweenObj["alpha"] = _componentVO.displayProperties.alpha;
			}
			
			if (!isNaN(_componentVO.displayProperties.rotation))
			{
				tweenObj["rotation"] = _componentVO.displayProperties.rotation;
			}			
			
			return tweenObj;
		}
		
		public function SaveProperties() : void
		{
			var save : Object = new Object();
				
			save["x"] = this.x;
			save["y"] = this.y;
			save["width"] = this.width;
			save["height"] = this.height;
			save["alpha"] = this.alpha;
			save["rotation"] = this.rotation;
			save["depth"] = this.depth;
			save["pivotX"] = this.pivotX;
			save["pivotY"] = this.pivotY;
			save["filters"] = this.filters;
			
			save["name"] = _componentVO.name + "::save_properties";
			_savedDisplayProperties = new DisplayPropertiesVO(save);
		}
		
		public function RestoreProperties() : void
		{
			if (_savedDisplayProperties == null) return;
			this.x = _savedDisplayProperties.x;
			this.y = _savedDisplayProperties.y;
			this.width = _savedDisplayProperties.width;
			this.height = _savedDisplayProperties.height;
			this.alpha = _savedDisplayProperties.alpha;
			this.rotation = _savedDisplayProperties.rotation;
			this.depth = _savedDisplayProperties.depth;
			this.filters = _savedDisplayProperties.filters;
			this.pivotX = _savedDisplayProperties.pivotX;
			this.pivotY = _savedDisplayProperties.pivotY;
		}
		
		public virtual function Enter(time : Number) : void
		{}
		
		public virtual function Exit(time : Number) : void
		{}
	}
}
