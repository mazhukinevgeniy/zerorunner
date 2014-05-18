package view.themes 
{
	import feathers.controls.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	
	public class GameTheme extends ThemeBase
	{
		public static const MENU_TOGGLE:String = "Menu-toggle-button";
		
		public static const MENU_BUTTON:String = "Menu-button";
		
		public function GameTheme(gameContainer:DisplayObjectContainer, atlas:TextureAtlas) 
		{
			super(gameContainer, atlas);
			
			this.setInitializerForClass(Button, this.menuButtonInitializer, GameTheme.MENU_BUTTON);
			this.setInitializerForClass(Button, this.menuTogglerInitializer, GameTheme.MENU_TOGGLE);
		}
		
		private function menuButtonInitializer(button:Button):void
		{
			this.defaultButtonInitializer(button);
		}
		
		private function menuTogglerInitializer(button:Button):void
		{
			this.defaultButtonInitializer(button);
			
			button.width = 30;
			button.height = 30;
			
			
		}
	}

}