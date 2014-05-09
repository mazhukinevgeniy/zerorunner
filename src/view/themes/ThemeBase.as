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
	import flash.text.TextFormatAlign;
	import flash.utils.Dictionary;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.TextureAtlas;
	
	internal class ThemeBase extends DisplayListWatcher
	{
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
		}*/
		//TODO: check if it's getting used
		
		
		private const BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 70, 10);
		
		protected var atlas:TextureAtlas;
		
		protected var fantasqueTextFormat:BitmapFontTextFormat;
		protected var bananaBrickTextFormat:BitmapFontTextFormat;
		
		protected var buttonTextures:Dictionary;
		protected var sliderTextures:Dictionary;
		
		public function ThemeBase(container:DisplayObjectContainer, atlas:TextureAtlas) 
		{
			super(container);
			this.atlas = atlas;
			
			this.buttonTextures = new Dictionary();
			this.sliderTextures = new Dictionary();
			
			
			this.initializeTextFormats();
			this.initializeButtonTextures();
			this.initializeSliderTextures();
			
			this.setInitializers();
		}
		
		protected function initializeTextFormats():void
		{
			this.fantasqueTextFormat = 
				new BitmapFontTextFormat("FantasqueSansMono", 32);
			
			this.fantasqueTextFormat.align = TextFormatAlign.CENTER;
			
			
			this.bananaBrickTextFormat =
				new BitmapFontTextFormat("BananaBrick", 92);
			
			this.bananaBrickTextFormat.align = TextFormatAlign.CENTER;
		}
		
		protected function initializeButtonTextures():void
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
		
		protected function initializeSliderTextures():void
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
		
		
		protected function setInitializers():void
		{
			this.setInitializerForClass(Label, this.defaultLabelInitializer);
			
			this.setInitializerForClass(Button, this.defaultButtonInitializer);
			this.setInitializerForClass(Slider, this.defaultSliderInitializer);
		}
		
		
		
		protected function defaultLabelInitializer(label:Label):void
		{
			label.textRendererProperties.textFormat = this.fantasqueTextFormat;
		}
		
		protected function defaultButtonInitializer(button:Button):void
		{
			button.defaultSkin = new Scale9Image(this.buttonTextures["button-up-skin"]);
			button.hoverSkin = new Scale9Image(this.buttonTextures["button-hover-skin"]);
			button.downSkin = new Scale9Image(this.buttonTextures["button-down-skin"]);
			
			button.defaultLabelProperties.textFormat = this.fantasqueTextFormat;
			
			button.paddingTop = button.paddingBottom = 2;
			button.paddingLeft = button.paddingRight = 2;
			
			button.minWidth = button.minHeight = 12;
		}
		
		protected function defaultSliderInitializer(slider:Slider):void
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
			else
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
			
				//slider.width = 200;
				//TODO: remove if fine without it
			}
			
			slider.step = 1;
			slider.page = 10;
			//TODO: initialize for named sliders
		}
	}

}