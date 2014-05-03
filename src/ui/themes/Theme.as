package ui.themes 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.ScrollBar;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Slider;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.core.FocusManager;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import game.GameElements;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import ui.navigation.Navigation;
	
	public class Theme extends DisplayListWatcher
	{
		public static const SOUND_SETTING:String = "SOUND_SETTING";
		public static const MUSIC_SETTING:String = "MUSIC_SETTING";
		
		protected static const FOCUS_INDICATOR_SCALE_9_GRID:Rectangle = new Rectangle(5, 4, 1, 14);
		protected static const BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 70, 10);
		protected static const SELECTED_BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 52, 10);
		
		protected static const HSLIDER_FIRST_REGION:Number = 2;
		protected static const HSLIDER_SECOND_REGION:Number = 75;
		
		protected static const PRIMARY_TEXT_COLOR:uint = 0x0B333C;
		protected static const DISABLED_TEXT_COLOR:uint = 0xAAB3B3;
		
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
		}
		
		public function Theme(elements:GameElements, container:DisplayObjectContainer) 
		{
			super(container);
			
			this.initialize(elements);
		}
		
		protected static function textRendererFactory():ITextRenderer
		{
			return new TextFieldTextRenderer();
		}
		
		protected var atlas:TextureAtlas;
		
		protected var defaultTextFormat:TextFormat;
		protected var disabledTextFormat:TextFormat;
		
		protected var focusIndicatorSkinTextures:Scale9Textures;
		
		protected var buttonUpSkinTextures:Scale9Textures;
		protected var buttonHoverSkinTextures:Scale9Textures;
		protected var buttonDownSkinTextures:Scale9Textures;
		protected var buttonDisabledSkinTextures:Scale9Textures;
		protected var buttonSelectedUpSkinTextures:Scale9Textures;
		protected var buttonSelectedHoverSkinTextures:Scale9Textures;
		protected var buttonSelectedDownSkinTextures:Scale9Textures;
		protected var buttonSelectedDisabledSkinTextures:Scale9Textures;
		
		protected var hSliderThumbUpSkinTexture:Texture;
		protected var hSliderThumbHoverSkinTexture:Texture;
		protected var hSliderThumbDownSkinTexture:Texture;
		protected var hSliderThumbDisabledSkinTexture:Texture;
		protected var hSliderTrackSkinTextures:Scale3Textures;

		protected var vSliderThumbUpSkinTexture:Texture;
		protected var vSliderThumbHoverSkinTexture:Texture;
		protected var vSliderThumbDownSkinTexture:Texture;
		protected var vSliderThumbDisabledSkinTexture:Texture;
		protected var vSliderTrackSkinTextures:Scale3Textures;
		
		protected function initialize(elements:GameElements):void
		{
			FocusManager.isEnabled = true;
			
			FeathersControl.defaultTextRendererFactory = textRendererFactory;

			this.atlas = elements.assets.getTextureAtlas("sprites");

			this.defaultTextFormat = new TextFormat("HiLo-Deco", 18, Theme.PRIMARY_TEXT_COLOR, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
			this.disabledTextFormat = new TextFormat("HiLo-Deco", 18, Theme.DISABLED_TEXT_COLOR, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);

			this.focusIndicatorSkinTextures = new Scale9Textures(this.atlas.getTexture("focus-indicator-skin"), FOCUS_INDICATOR_SCALE_9_GRID);

			this.buttonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-up-skin"), BUTTON_SCALE_9_GRID);
			this.buttonHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("button-hover-skin"), BUTTON_SCALE_9_GRID);
			this.buttonDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-down-skin"), BUTTON_SCALE_9_GRID);
			this.buttonDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("button-disabled-skin"), BUTTON_SCALE_9_GRID);
			this.buttonSelectedUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-up-skin"), SELECTED_BUTTON_SCALE_9_GRID);
			this.buttonSelectedHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-hover-skin"), SELECTED_BUTTON_SCALE_9_GRID);
			this.buttonSelectedDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-down-skin"), SELECTED_BUTTON_SCALE_9_GRID);
			this.buttonSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-disabled-skin"), SELECTED_BUTTON_SCALE_9_GRID);
			
			this.hSliderThumbUpSkinTexture = this.atlas.getTexture("hslider-thumb-up-skin");
			this.hSliderThumbHoverSkinTexture = this.atlas.getTexture("hslider-thumb-hover-skin");
			this.hSliderThumbDownSkinTexture = this.atlas.getTexture("hslider-thumb-down-skin");
			this.hSliderThumbDisabledSkinTexture = this.atlas.getTexture("hslider-thumb-disabled-skin");
			this.hSliderTrackSkinTextures = new Scale3Textures(this.atlas.getTexture("hslider-track-skin"), HSLIDER_FIRST_REGION, HSLIDER_SECOND_REGION, Scale3Textures.DIRECTION_HORIZONTAL);

			this.vSliderThumbUpSkinTexture = this.atlas.getTexture("vslider-thumb-up-skin");
			this.vSliderThumbHoverSkinTexture = this.atlas.getTexture("vslider-thumb-hover-skin");
			this.vSliderThumbDownSkinTexture = this.atlas.getTexture("vslider-thumb-down-skin");
			this.vSliderThumbDisabledSkinTexture = this.atlas.getTexture("vslider-thumb-disabled-skin");
			this.vSliderTrackSkinTextures = new Scale3Textures(this.atlas.getTexture("vslider-track-skin"), HSLIDER_FIRST_REGION, HSLIDER_SECOND_REGION, Scale3Textures.DIRECTION_VERTICAL);
			
			this.setInitializerForClass(Button, this.buttonInitializer);
			this.setInitializerForClass(Label, this.labelInitializer);
			this.setInitializerForClass(Slider, this.sliderInitializer);
			this.setInitializerForClass(Button, this.soundButtonInitializer, Theme.SOUND_SETTING);
		}
		
		protected function soundButtonInitializer(button:Button):void
		{
			this.buttonInitializer(button);
			
			button.width = 30;
			button.height = 30;
		}
		
		protected function buttonInitializer(button:Button):void
		{
			button.defaultSkin = new Scale9Image(buttonUpSkinTextures);
			button.hoverSkin = new Scale9Image(buttonHoverSkinTextures);
			button.downSkin = new Scale9Image(buttonDownSkinTextures);
			button.disabledSkin = new Scale9Image(buttonDisabledSkinTextures);
			button.defaultSelectedSkin = new Scale9Image(buttonSelectedUpSkinTextures);
			button.selectedHoverSkin = new Scale9Image(buttonSelectedHoverSkinTextures);
			button.selectedDownSkin = new Scale9Image(buttonSelectedDownSkinTextures);
			button.selectedDisabledSkin = new Scale9Image(buttonSelectedDisabledSkinTextures);

			button.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
			button.focusPadding = -1;
			
			button.defaultLabelProperties.embedFonts = true;
			button.defaultLabelProperties.textFormat = this.defaultTextFormat;
			button.disabledLabelProperties.textFormat = this.disabledTextFormat;

			button.paddingTop = button.paddingBottom = 2;
			button.paddingLeft = button.paddingRight = 10;
			button.gap = 2;
			button.minWidth = button.minHeight = 12;
		}
		
		protected function labelInitializer(label:Label):void
		{
			label.textRendererProperties.textFormat = this.defaultTextFormat;
		}
		
		protected function sliderInitializer(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_SINGLE;
			slider.minimumPadding = slider.maximumPadding = -vSliderThumbUpSkinTexture.height / 2;

			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				slider.thumbProperties.defaultSkin = new Image(vSliderThumbUpSkinTexture);
				slider.thumbProperties.hoverSkin = new Image(vSliderThumbHoverSkinTexture);
				slider.thumbProperties.downSkin = new Image(vSliderThumbDownSkinTexture);
				slider.thumbProperties.disabledSkin = new Image(vSliderThumbDisabledSkinTexture);
				slider.minimumTrackProperties.defaultSkin = new Scale3Image(vSliderTrackSkinTextures);
				slider.focusPaddingLeft = slider.focusPaddingRight = -2;
				slider.focusPaddingTop = slider.focusPaddingBottom = -2 + slider.minimumPadding;
			}
			else //horizontal
			{
				slider.thumbProperties.defaultSkin = new Image(hSliderThumbUpSkinTexture);
				slider.thumbProperties.hoverSkin = new Image(hSliderThumbHoverSkinTexture);
				slider.thumbProperties.downSkin = new Image(hSliderThumbDownSkinTexture);
				slider.thumbProperties.disabledSkin = new Image(hSliderThumbDisabledSkinTexture);
				slider.minimumTrackProperties.defaultSkin = new Scale3Image(hSliderTrackSkinTextures);
				slider.focusPaddingTop = slider.focusPaddingBottom = -2;
				slider.focusPaddingLeft = slider.focusPaddingRight = -2 + slider.minimumPadding;
			}

			slider.focusIndicatorSkin = new Scale9Image(this.focusIndicatorSkinTextures);
			
			slider.minimum = 0;
			slider.maximum = 100;
			
			slider.step = 1;
			slider.page = 10;
			
			slider.width = 200;
		}
		
		
	}

}