package game 
{
	import feathers.controls.Button;
	import feathers.core.DisplayListWatcher;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	import starling.utils.Color;
	
	public class GameTheme extends DisplayListWatcher
	{
		public static const TRIANGLE_TOGGLE:String = "Triangle-toggle-button";
		public static const MENU_BUTTON:String = "Menu-button";
		
		private var atlas:TextureAtlas;
		
		private var defaultTextFormat:TextFormat;
		
		public function GameTheme(gameContainer:DisplayObjectContainer, atlas:TextureAtlas) 
		{
			super(gameContainer);
			
			this.atlas = atlas;
			
			this.defaultTextFormat = new TextFormat("HiLo-Deco", 18, Color.BLACK, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
			
			this.setInitializerForClass(Button, this.initializeMenuButton, GameTheme.MENU_BUTTON);
			this.setInitializerForClass(Button, this.initializeTTButton, GameTheme.TRIANGLE_TOGGLE);
		}
		
		private function initializeMenuButton(button:Button):void
		{
			button.defaultSkin = new Image(this.atlas.getTexture("button-up-skin"));
			button.hoverSkin = new Image(this.atlas.getTexture("button-hover-skin"));
			button.downSkin = new Image(this.atlas.getTexture("button-down-skin"));
			button.defaultSelectedSkin = new Image(this.atlas.getTexture("button-selected-up-skin"));
			button.selectedHoverSkin = new Image(this.atlas.getTexture("button-selected-hover-skin"));
			button.selectedDownSkin = new Image(this.atlas.getTexture("button-selected-down-skin"));
			
			button.defaultLabelProperties = this.defaultTextFormat;
		}
		
		private function initializeTTButton(button:Button):void
		{
			button.scaleX = -2;//TODO: that's wrong, must just have the right sprite
			button.scaleY = 2;
			button.upSkin = new Image(this.atlas.getTexture("vslider-thumb-up-skin"));
			button.hoverSkin = new Image(this.atlas.getTexture("vslider-thumb-hover-skin"));
			button.downSkin = new Image(this.atlas.getTexture("vslider-thumb-down-skin"));
			button.defaultSelectedSkin = button.upSkin;
			button.selectedHoverSkin = button.hoverSkin;
			button.selectedDownSkin = button.downSkin;
			//TODO: add more sprites
		}
	}

}