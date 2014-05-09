package view.themes 
{
	import feathers.controls.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	
	public class GameTheme extends ThemeBase
	{
		public static const TRIANGLE_TOGGLE:String = "Triangle-toggle-button";
		public static const MENU_BUTTON:String = "Menu-button";
		
		public static const TOGGLE_MAP:String = "Toggle-map";
		public static const QUIT_GAME:String = "Quit-game";
		
		public function GameTheme(gameContainer:DisplayObjectContainer, atlas:TextureAtlas) 
		{
			super(gameContainer, atlas);
			
			this.setInitializerForClass(Button, this.menuButtonInitializer, GameTheme.MENU_BUTTON);
			this.setInitializerForClass(Button, this.menuTogglerInitializer, GameTheme.TRIANGLE_TOGGLE);
		}
		
		private function menuButtonInitializer(button:Button):void
		{
			this.defaultButtonInitializer(button);
			
			
			if (button.nameList.contains(GameTheme.TOGGLE_MAP))
			{
				button.label = "MAP";
			}
			else if (button.nameList.contains(GameTheme.QUIT_GAME))
			{
				button.label = "QUIT GAME";
				//TODO: shorten to "quit" asap;
				//probably must replace "map" with "back" when map is open
			}
		}
		
		private function menuTogglerInitializer(button:Button):void
		{
			button.scaleX = 2;
			button.scaleY = 2;
			
			button.upSkin = new Image(this.sliderTextures["hslider-thumb-up-skin"]);
			button.hoverSkin = new Image(this.sliderTextures["hslider-thumb-hover-skin"]);
			button.downSkin = new Image(this.sliderTextures["hslider-thumb-down-skin"]);
		}
	}

}