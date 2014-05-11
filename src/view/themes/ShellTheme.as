package view.themes 
{
	import feathers.controls.Button;
	import feathers.controls.Check;
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
			
			this.setInitializerForClass(Check, this.muteCheckBoxInitializer, ShellTheme.TOGGLE_MUTE);
		}
		
		
		private function navigationButtonInitializer(button:Button):void
		{
			this.defaultButtonInitializer(button);
			
			button.defaultLabelProperties.textFormat = this.bananaBrickTextFormat;
			
			button.labelOffsetY = 8;
			
			button.height = 60;
			button.width = 320;
		}
		
		
		private function muteCheckBoxInitializer(check:Check):void
		{
			this.defaultCheckBoxInitializer(check);
			
			
			if (check.nameList.contains(ShellTheme.MUSIC))
			{
				check.label = "MUSIC";
			}
			else if (check.nameList.contains(ShellTheme.SOUND))
			{
				check.label = "SOUND";
			}
			
		}
	}

}