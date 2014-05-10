package view.themes 
{
	import feathers.controls.Button;
	import starling.display.DisplayObjectContainer;
	import starling.textures.TextureAtlas;
	
	public class ShellTheme extends ThemeBase
	{
		public static const NAVIGATION_BUTTON:String = "NAVIGATION_BUTTON";
		
		public static const TOGGLE_MUTE:String = "TOGGLE_MUTE";
		
		public static const SOUND:String = "SOUND";
		public static const MUSIC:String = "MUSIC";
		
		
		public function ShellTheme(container:DisplayObjectContainer, atlas:TextureAtlas) 
		{
			super(container, atlas);
		}
		
		override protected function setInitializers():void 
		{
			super.setInitializers();
			
			this.setInitializerForClass(Button, this.navigationButtonInitializer, ShellTheme.NAVIGATION_BUTTON);
			this.setInitializerForClass(Button, this.toggleMuteButtonInitializer, ShellTheme.TOGGLE_MUTE);
		}
		
		
		private function navigationButtonInitializer(button:Button):void
		{
			this.defaultButtonInitializer(button);
			
			button.defaultLabelProperties.textFormat = this.bananaBrickTextFormat;
			
			button.labelOffsetY = 8;
			
			button.height = 60;
			button.width = 320;
		}
		
		
		private function toggleMuteButtonInitializer(button:Button):void
		{
			this.defaultButtonInitializer(button);
			
			//temporary
			if (button.nameList.contains(ShellTheme.MUSIC))
			{
				button.label = "M";
			}
			else if (button.nameList.contains(ShellTheme.SOUND))
			{
				button.label = "S";
			}
			
			button.width = 30;
			button.height = 30;
			
			//TODO: fix view; it'd have different skin etc
		}
		
		
	}

}