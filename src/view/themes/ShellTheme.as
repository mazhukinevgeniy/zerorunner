package view.themes 
{
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Slider;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.extensions.PreciseBitmapFontTextRenderer;
	import starling.textures.TextureAtlas;
	
	public class ShellTheme extends ThemeBase
	{
		public static const NAVIGATION_BUTTON:String = "NAVIGATION_BUTTON";
		
		public static const SOUND_REGULATOR:String = "SOUND_REGULATOR";
		public static const SOUND:Vector.<String> = Vector.<String>(["EFFECT", "MUSIC"]);
		
		public function ShellTheme(container:DisplayObjectContainer, atlas:TextureAtlas) 
		{
			super(container, atlas);
		}
		
		override protected function setInitializers():void 
		{
			super.setInitializers();
			
			this.setInitializerForClass(Button, this.navigationButtonInitializer, ShellTheme.NAVIGATION_BUTTON);
			
			this.setInitializerForClass(Check, this.muteCheckBoxInitializer, ShellTheme.SOUND_REGULATOR);
			this.setInitializerForClass(Slider, this.volumeSliderInitializer, ShellTheme.SOUND_REGULATOR);
		}
		
		
		private function navigationButtonInitializer(button:Button):void
		{
			this.defaultButtonInitializer(button);
			
			button.labelFactory = this.createLabelFactory;
			
			button.defaultLabelProperties.textFormat = this.bananaTextFormat;
			
			button.labelOffsetY = 8;
			
			button.height = 60;
			button.width = 320;
		}
		
		
		private function muteCheckBoxInitializer(check:Check):void
		{
			this.defaultCheckBoxInitializer(check);
			
			
			if (check.nameList.contains(ShellTheme.SOUND[View.SOUND_MUSIC]))
			{
				check.label = "Music";
			}
			else if (check.nameList.contains(ShellTheme.SOUND[View.SOUND_EFFECT]))
			{
				check.label = "Sound";
			}
			
		}
		
		private function volumeSliderInitializer(slider:Slider):void
		{
			this.defaultSliderInitializer(slider);
			
			slider.page = 20;
		}
		
		private function createLabelFactory():PreciseBitmapFontTextRenderer
		{
			return new PreciseBitmapFontTextRenderer();
		}
	}

}