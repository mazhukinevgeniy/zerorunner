package view.themes 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.Slider;
	import feathers.core.DisplayListWatcher;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.text.BitmapFontTextFormat;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	
	public class ShellTheme extends DisplayListWatcher
	{
		public static const SOUND_SETTING:String = "SOUND_SETTING";
		public static const MUSIC_SETTING:String = "MUSIC_SETTING";
		
		protected static const PRIMARY_TEXT_COLOR:uint = 0x0B333C;
		
		/*
		protected static function verticalScrollBarFactory():ScrollBar
		{
			const scrollBar:ScrollBar = new ScrollBar();
			scrollBar.direction = ScrollBar.DIRECTION_VERTICAL;
			return scrollBar;
		}

		protected static function horizontalScrollBarFactory():ScrollBar
		{
			const scrollBar:ScrollBar = new ScrollBar();
			scrollBar.direction = ScrollBar.DIRECTION_HORIZONTAL;
			return scrollBar;
		}*///TODO: check if it's getting used
		
		private const BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 70, 10);
		
		protected var defaultTextFormat:BitmapFontTextFormat;
		
		private var atlas:TextureAtlas;
		private var buttonTextures:Dictionary;
		private var sliderTextures:Dictionary;
		
		
		public function ShellTheme(container:DisplayObjectContainer, atlas:TextureAtlas) 
		{
			super(container);
			
			this.atlas = atlas;
			
			this.buttonTextures = new Dictionary();
			this.sliderTextures = new Dictionary();
			
			
			this.initializeTextFormat();
			
			this.initializeButtonTextures();
			this.initializeSliderTextures();
			
			this.setInitializers();
		}
		
		
		private function initializeTextFormat():void
		{
			this.defaultTextFormat = 
				new BitmapFontTextFormat("bananaBrick", 72);
		}
		
		private function initializeButtonTextures():void
		{
			var name:String;
			
			var names:Array =
				[
					"button-up-skin",
					"button-hover-skin",
					"button-down-skin"
				];
			
			for each (name in names)
			{
				this.buttonTextures[name] = 
					new Scale9Textures(this.atlas.getTexture(name), this.BUTTON_SCALE_9_GRID);
			}
		}
		
		private function initializeSliderTextures():void
		{
			var name:String;
			
			var names:Array = 
				[
					"hslider-thumb-up-skin",
					"hslider-thumb-hover-skin",
					"hslider-thumb-down-skin",
					
					"vslider-thumb-up-skin",
					"vslider-thumb-hover-skin",
					"vslider-thumb-down-skin"
				]
			
			for each (name in names)
			{
				this.sliderTextures[name] = 
					this.atlas.getTexture(name);
			}
			
			
			const HSLIDER_FIRST_REGION:Number = 2;
			const HSLIDER_SECOND_REGION:Number = 75;
			
			this.sliderTextures["hslider-track-skin"] = 
				new Scale3Textures(this.atlas.getTexture("hslider-track-skin"), 
				                   HSLIDER_FIRST_REGION, 
								   HSLIDER_SECOND_REGION, 
								   Scale3Textures.DIRECTION_HORIZONTAL);

			this.sliderTextures["vslider-track-skin"] =
				new Scale3Textures(this.atlas.getTexture("vslider-track-skin"), 
				                   HSLIDER_FIRST_REGION, 
								   HSLIDER_SECOND_REGION, 
								   Scale3Textures.DIRECTION_VERTICAL);
		}
		
		private function setInitializers():void
		{
			this.setInitializerForClass(Button, this.buttonInitializer);
			this.setInitializerForClass(Button, this.soundButtonInitializer, ShellTheme.SOUND_SETTING);
			
			this.setInitializerForClass(Label, this.labelInitializer);
			this.setInitializerForClass(Slider, this.sliderInitializer);
			
			//TODO: improve it, we have names after all
		}
		
		protected function soundButtonInitializer(button:Button):void
		{
			this.buttonInitializer(button);
			
			button.width = 30;
			button.height = 30;
		}
		
		protected function buttonInitializer(button:Button):void
		{
			button.defaultSkin = new Scale9Image(this.buttonTextures["button-up-skin"]);
			button.hoverSkin = new Scale9Image(this.buttonTextures["button-hover-skin"]);
			button.downSkin = new Scale9Image(this.buttonTextures["button-down-skin"]);
			
			button.defaultLabelProperties.embedFonts = true;
			button.defaultLabelProperties.textFormat = this.defaultTextFormat;

			button.paddingTop = button.paddingBottom = 2;
			button.paddingLeft = button.paddingRight = 10;
			button.gap = 2;
			button.minWidth = button.minHeight = 80;
			button.height = 80;
			button.width = Main.WIDTH;
		}
		
		protected function labelInitializer(label:Label):void
		{
			label.textRendererProperties.textFormat = this.defaultTextFormat;
		}
		
		protected function sliderInitializer(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_SINGLE;
			slider.minimumPadding = slider.maximumPadding = 
				-this.sliderTextures["vslider-thumb-up-skin"].height / 2;

			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				slider.thumbProperties.defaultSkin = 
					new Image(this.sliderTextures["vslider-thumb-up-skin"]);
				slider.thumbProperties.hoverSkin = 
					new Image(this.sliderTextures["vslider-thumb-hover-skin"]);
				slider.thumbProperties.downSkin = 
					new Image(this.sliderTextures["vslider-thumb-down-skin"]);
				slider.minimumTrackProperties.defaultSkin = 
					new Scale3Image(this.sliderTextures["vslider-track-skin"]);
				
				slider.focusPaddingLeft = slider.focusPaddingRight = -2;
				slider.focusPaddingTop = slider.focusPaddingBottom = -2 + slider.minimumPadding;
			}
			else //horizontal
			{
				slider.thumbProperties.defaultSkin = 
					new Image(this.sliderTextures["hslider-thumb-up-skin"]);
				slider.thumbProperties.hoverSkin = 
					new Image(this.sliderTextures["hslider-thumb-hover-skin"]);
				slider.thumbProperties.downSkin = 
					new Image(this.sliderTextures["hslider-thumb-down-skin"]);
				slider.minimumTrackProperties.defaultSkin = 
					new Scale3Image(this.sliderTextures["hslider-track-skin"]);
				
				slider.focusPaddingTop = slider.focusPaddingBottom = -2;
				slider.focusPaddingLeft = slider.focusPaddingRight = -2 + slider.minimumPadding;
			
				//slider.width = 200;//TODO: remove if fine without it
			}
			
			slider.step = 1;
			slider.page = 10;
		}
		
		
	}

}