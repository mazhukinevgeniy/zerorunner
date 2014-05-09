package view.themes 
{
	import feathers.controls.Button;
	import feathers.core.DisplayListWatcher;
	import feathers.text.BitmapFontTextFormat;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	import starling.utils.Color;
	
	public class GameTheme extends DisplayListWatcher
	{
		public static const TRIANGLE_TOGGLE:String = "Triangle-toggle-button";
		public static const MENU_BUTTON:String = "Menu-button";
		public static const QUIT_GAME:String = "Quit-game";
		public static const TOGGLE_MAP:String = "Toggle-map";
		
		private var atlas:TextureAtlas;
		
		private var defaultTextFormat:BitmapFontTextFormat;
		
		public function GameTheme(gameContainer:DisplayObjectContainer, atlas:TextureAtlas) 
		{
			super(gameContainer);
			
			this.atlas = atlas;
			
			this.defaultTextFormat = new BitmapFontTextFormat("hiloDeco", 20);
			//TODO: avoid that downscaling
			
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
			//TODO: optimize, must not create textures every time
			
			button.defaultLabelProperties.textFormat = this.defaultTextFormat;
			
			if (button.nameList.contains(GameTheme.TOGGLE_MAP))
			{
				button.label = "Toggle map";
			}
			else if (button.nameList.contains(GameTheme.QUIT_GAME))
			{
				button.label = "Quit game";
			}
		}
		
		private function initializeTTButton(button:Button):void
		{
			button.scaleX = 2;
			button.scaleY = 2;
			button.upSkin = new Image(this.atlas.getTexture("hslider-thumb-up-skin"));
			button.hoverSkin = new Image(this.atlas.getTexture("hslider-thumb-hover-skin"));
			button.downSkin = new Image(this.atlas.getTexture("hslider-thumb-down-skin"));
			button.defaultSelectedSkin = button.upSkin;
			button.selectedHoverSkin = button.hoverSkin;
			button.selectedDownSkin = button.downSkin;
			//TODO: add more sprites
		}
	}

}