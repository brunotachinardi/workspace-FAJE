package com.eguru.faje.mvcs.views.components {
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import com.eguru.faje.mvcs.models.data.components.GraphicComponentVO;
	import com.eguru.faje.mvcs.models.IAssetModel;
	import com.eguru.faje.mvcs.models.data.components.core.ComponentVO;
	import com.eguru.faje.mvcs.views.components.core.ComponentView;

	/**
	 * @author Bruno Tachinardi
	 */
	public class GraphicComponentView extends ComponentView 
	{
		
		protected var _graphicVO : GraphicComponentVO;
		protected var _image : DisplayObject;
		
		override public function Initialize(componentVO : ComponentVO, assets : IAssetModel) : void
		{
			super.Initialize(componentVO, assets);
			_graphicVO = componentVO as GraphicComponentVO;
			_image = addChild(assets.GetAssetContentByName(_graphicVO.imageName));
		}
		
		
		public function StopAnimation(name : String) : void
		{
			var target : MovieClip = SearchForNamedMC(this, name);
			if (target != null) 
			{
				target.gotoAndStop(target.totalFrames-1);
			}
		}
		
		protected function SearchForNamedMC(image : DisplayObjectContainer, targetName : String) : MovieClip 
		{
			if (image.name == targetName) return image as MovieClip;
			for (var i : int = 0; i < image.numChildren; i++) 
			{
				var child : DisplayObject = image.getChildAt(i);
				if (child is DisplayObjectContainer)
				{
					var result : MovieClip = SearchForNamedMC(child as DisplayObjectContainer, targetName);
					if (result != null) return result;	
				}
			}
			return null;
		}
	}
}
