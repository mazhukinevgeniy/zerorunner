package ui.themes 
{
	import feathers.controls.Button;
	import feathers.controls.ScrollBar;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Slider;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.core.FocusManager;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
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
		protected static const FOCUS_INDICATOR_SCALE_9_GRID:Rectangle = new Rectangle(5, 4, 1, 14);
		protected static const BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 70, 10);
		protected static const SELECTED_BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 52, 10);
		
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
			
			this.setInitializerForClass(Button, this.buttonInitializer);
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
		
		
	}

}