package view.themes 
{
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Slider;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	import view.shell.controls.SingularMemory;
	
	public class ShellTheme extends ThemeBase
	{
		public static const NAVIGATION_BUTTON:String = "NAVIGATION_BUTTON";
		
		public static const SOUND_REGULATOR:String = "SOUND_REGULATOR";
		public static const SOUND:Vector.<String> = Vector.<String>(["EFFECT", "MUSIC"]);
		
		public static const MEMORY_LOCKED:String = "LOCKED";
		public static const MEMORY_UNLOCKED:String = "UNLOCKED";
		
		public function ShellTheme(container:DisplayObjectContainer, atlas:TextureAtlas) 
		{
			super(container, atlas);
		}
		
		override protected function setInitializers():void 
		{
			super.setInitializers();
			
			this.setInitializerForClass(Button, this.navigationButtonInitializer, ShellTheme.NAVIGATION_BUTTON);
			
			this.setInitializerForClass(SingularMemory, this.singularMemoryInitializer);
			
			this.setInitializerForClass(Check, this.muteCheckBoxInitializer, ShellTheme.SOUND_REGULATOR);
			this.setInitializerForClass(Slider, this.volumeSliderInitializer, ShellTheme.SOUND_REGULATOR);
		}
		
		
		private function navigationButtonInitializer(button:Button):void
		{
			this.defaultButtonInitializer(button);
			
			button.defaultLabelProperties.textFormat = this.bananaBrickTextFormat;
			
			button.labelOffsetY = 8;
			
			button.height = 60;
			button.width = 320;
		}
		
		private function singularMemoryInitializer(memory:SingularMemory):void
		{
			var skin:Image = new Image(this.atlas.getTexture("unimplemented"));
			skin.scaleX = skin.scaleY = 1.3;
			
			memory.addChild(skin);
			
			if (memory.nameList.contains(ShellTheme.MEMORY_LOCKED))
			{
				memory.alpha *= 0.5;
			}
			else if (memory.nameList.contains(ShellTheme.MEMORY_UNLOCKED))
			{
				
			}
			else throw new Error();
		}
		
		
		private function muteCheckBoxInitializer(check:Check):void
		{
			this.defaultCheckBoxInitializer(check);
			
			
			if (check.nameList.contains(ShellTheme.SOUND[View.SOUND_MUSIC]))
			{
				check.label = "MUSIC";
			}
			else if (check.nameList.contains(ShellTheme.SOUND[View.SOUND_EFFECT]))
			{
				check.label = "SOUND";
			}
			
		}
		
		private function volumeSliderInitializer(slider:Slider):void
		{
			this.defaultSliderInitializer(slider);
			
			slider.page = 20;
		}
	}

}