package ui.themes 
{
	import feathers.controls.Button;
	import feathers.controls.Callout;
	import feathers.controls.text.TextFieldTextEditor;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.core.FocusManager;
	import feathers.core.ITextEditor;
	import feathers.core.ITextRenderer;
	import feathers.display.Scale9Image;
	import feathers.textures.Scale9Textures;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import game.GameElements;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.textures.TextureAtlas;
	
	public class Theme extends DisplayListWatcher
	{
		protected static const FOCUS_INDICATOR_SCALE_9_GRID:Rectangle = new Rectangle(5, 4, 1, 14);
		protected static const BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 70, 10);
		protected static const SELECTED_BUTTON_SCALE_9_GRID:Rectangle = new Rectangle(6, 6, 52, 10);
		
		protected static const PRIMARY_TEXT_COLOR:uint = 0x0B333C;
		protected static const DISABLED_TEXT_COLOR:uint = 0xAAB3B3;
		
		public function Theme(elements:GameElements, container:DisplayObjectContainer) 
		{
			super(container);
			
			//Starling.current.nativeStage.color = BACKGROUND_COLOR;
			/*if(this.root.stage)
			{
				this.root.stage.color = BACKGROUND_COLOR;
			}
			else
			{
				this.root.addEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
			}*/
			
			this.initialize(elements);
		}
		
		protected static function textRendererFactory():ITextRenderer
		{
			return new TextFieldTextRenderer();
		}

		protected static function textEditorFactory():ITextEditor
		{
			return new TextFieldTextEditor();
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
			FeathersControl.defaultTextEditorFactory = textEditorFactory;

			//Callout.stagePaddingTop = Callout.stagePaddingRight = Callout.stagePaddingBottom =
				//Callout.stagePaddingLeft = 300;

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

			/*this.tabUpSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-up-skin"), TAB_SCALE_9_GRID);
			this.tabHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-hover-skin"), TAB_SCALE_9_GRID);
			this.tabDownSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-down-skin"), TAB_SCALE_9_GRID);
			this.tabDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-disabled-skin"), TAB_SCALE_9_GRID);
			this.tabSelectedUpSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-up-skin"), TAB_SCALE_9_GRID);
			this.tabSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-disabled-skin"), TAB_SCALE_9_GRID);

			this.stepperIncrementButtonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("numeric-stepper-increment-button-up-skin"), STEPPER_INCREMENT_BUTTON_SCALE_9_GRID);
			this.stepperIncrementButtonHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("numeric-stepper-increment-button-hover-skin"), STEPPER_INCREMENT_BUTTON_SCALE_9_GRID);
			this.stepperIncrementButtonDownSkinTextures = new Scale9Textures(this.atlas.getTexture("numeric-stepper-increment-button-down-skin"), STEPPER_INCREMENT_BUTTON_SCALE_9_GRID);
			this.stepperIncrementButtonDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("numeric-stepper-increment-button-disabled-skin"), STEPPER_INCREMENT_BUTTON_SCALE_9_GRID);

			this.stepperDecrementButtonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("numeric-stepper-decrement-button-up-skin"), STEPPER_DECREMENT_BUTTON_SCALE_9_GRID);
			this.stepperDecrementButtonHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("numeric-stepper-decrement-button-hover-skin"), STEPPER_DECREMENT_BUTTON_SCALE_9_GRID);
			this.stepperDecrementButtonDownSkinTextures = new Scale9Textures(this.atlas.getTexture("numeric-stepper-decrement-button-down-skin"), STEPPER_DECREMENT_BUTTON_SCALE_9_GRID);
			this.stepperDecrementButtonDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("numeric-stepper-decrement-button-disabled-skin"), STEPPER_DECREMENT_BUTTON_SCALE_9_GRID);

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

			this.itemRendererUpSkinTexture = this.atlas.getTexture("item-renderer-up-skin");
			this.itemRendererHoverSkinTexture = this.atlas.getTexture("item-renderer-hover-skin");
			this.itemRendererSelectedUpSkinTexture = this.atlas.getTexture("item-renderer-selected-up-skin");

			this.headerBackgroundSkinTextures = new Scale9Textures(this.atlas.getTexture("header-background-skin"), HEADER_SCALE_9_GRID);
			this.groupedListHeaderBackgroundSkinTextures = new Scale9Textures(this.atlas.getTexture("grouped-list-header-background-skin"), HEADER_SCALE_9_GRID);

			this.checkUpIconTexture = this.atlas.getTexture("check-up-icon");
			this.checkHoverIconTexture = this.atlas.getTexture("check-hover-icon");
			this.checkDownIconTexture = this.atlas.getTexture("check-down-icon");
			this.checkDisabledIconTexture = this.atlas.getTexture("check-disabled-icon");
			this.checkSelectedUpIconTexture = this.atlas.getTexture("check-selected-up-icon");
			this.checkSelectedHoverIconTexture = this.atlas.getTexture("check-selected-hover-icon");
			this.checkSelectedDownIconTexture = this.atlas.getTexture("check-selected-down-icon");
			this.checkSelectedDisabledIconTexture = this.atlas.getTexture("check-selected-disabled-icon");

			this.radioUpIconTexture = this.atlas.getTexture("radio-up-icon");
			this.radioHoverIconTexture = this.atlas.getTexture("radio-hover-icon");
			this.radioDownIconTexture = this.atlas.getTexture("radio-down-icon");
			this.radioDisabledIconTexture = this.atlas.getTexture("radio-disabled-icon");
			this.radioSelectedUpIconTexture = this.atlas.getTexture("radio-selected-up-icon");
			this.radioSelectedHoverIconTexture = this.atlas.getTexture("radio-selected-hover-icon");
			this.radioSelectedDownIconTexture = this.atlas.getTexture("radio-selected-down-icon");
			this.radioSelectedDisabledIconTexture = this.atlas.getTexture("radio-selected-disabled-icon");

			this.pageIndicatorNormalSkinTexture = this.atlas.getTexture("page-indicator-normal-skin");
			this.pageIndicatorSelectedSkinTexture = this.atlas.getTexture("page-indicator-selected-skin");

			this.pickerListUpIconTexture = this.atlas.getTexture("picker-list-up-icon");
			this.pickerListHoverIconTexture = this.atlas.getTexture("picker-list-hover-icon");
			this.pickerListDownIconTexture = this.atlas.getTexture("picker-list-down-icon");
			this.pickerListDisabledIconTexture = this.atlas.getTexture("picker-list-disabled-icon");

			this.textInputBackgroundSkinTextures = new Scale9Textures(this.atlas.getTexture("text-input-background-skin"), TEXT_INPUT_SCALE_9_GRID);
			this.textInputBackgroundDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("text-input-background-disabled-skin"), TEXT_INPUT_SCALE_9_GRID);

			this.vScrollBarThumbUpSkinTextures = new Scale9Textures(this.atlas.getTexture("vertical-scroll-bar-thumb-up-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.vScrollBarThumbHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("vertical-scroll-bar-thumb-hover-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.vScrollBarThumbDownSkinTextures = new Scale9Textures(this.atlas.getTexture("vertical-scroll-bar-thumb-down-skin"), VERTICAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.vScrollBarTrackSkinTextures = new Scale9Textures(this.atlas.getTexture("vertical-scroll-bar-track-skin"), VERTICAL_SCROLL_BAR_TRACK_SCALE_9_GRID);
			this.vScrollBarThumbIconTexture = this.atlas.getTexture("vertical-scroll-bar-thumb-icon");
			this.vScrollBarStepButtonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("vertical-scroll-bar-step-button-up-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.vScrollBarStepButtonHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("vertical-scroll-bar-step-button-hover-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.vScrollBarStepButtonDownSkinTextures = new Scale9Textures(this.atlas.getTexture("vertical-scroll-bar-step-button-down-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.vScrollBarStepButtonDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("vertical-scroll-bar-step-button-disabled-skin"), VERTICAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.vScrollBarDecrementButtonIconTexture = this.atlas.getTexture("vertical-scroll-bar-decrement-button-icon");
			this.vScrollBarIncrementButtonIconTexture = this.atlas.getTexture("vertical-scroll-bar-increment-button-icon");

			this.hScrollBarThumbUpSkinTextures = new Scale9Textures(this.atlas.getTexture("horizontal-scroll-bar-thumb-up-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.hScrollBarThumbHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("horizontal-scroll-bar-thumb-hover-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.hScrollBarThumbDownSkinTextures = new Scale9Textures(this.atlas.getTexture("horizontal-scroll-bar-thumb-down-skin"), HORIZONTAL_SCROLL_BAR_THUMB_SCALE_9_GRID);
			this.hScrollBarTrackTextures = new Scale9Textures(this.atlas.getTexture("horizontal-scroll-bar-track-skin"), HORIZONTAL_SCROLL_BAR_TRACK_SCALE_9_GRID);
			this.hScrollBarThumbIconTexture = this.atlas.getTexture("horizontal-scroll-bar-thumb-icon");
			this.hScrollBarStepButtonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("horizontal-scroll-bar-step-button-up-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.hScrollBarStepButtonHoverSkinTextures = new Scale9Textures(this.atlas.getTexture("horizontal-scroll-bar-step-button-hover-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.hScrollBarStepButtonDownSkinTextures = new Scale9Textures(this.atlas.getTexture("horizontal-scroll-bar-step-button-down-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.hScrollBarStepButtonDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("horizontal-scroll-bar-step-button-disabled-skin"), HORIZONTAL_SCROLL_BAR_STEP_BUTTON_SCALE_9_GRID);
			this.hScrollBarDecrementButtonIconTexture = this.atlas.getTexture("horizontal-scroll-bar-decrement-button-icon");
			this.hScrollBarIncrementButtonIconTexture = this.atlas.getTexture("horizontal-scroll-bar-increment-button-icon");

			this.simpleBorderBackgroundSkinTextures = new Scale9Textures(this.atlas.getTexture("simple-border-background-skin"), SIMPLE_BORDER_SCALE_9_GRID);
			this.panelBorderBackgroundSkinTextures = new Scale9Textures(this.atlas.getTexture("panel-background-skin"), PANEL_BORDER_SCALE_9_GRID);

			this.progressBarFillSkinTexture = this.atlas.getTexture("progress-bar-fill-skin");

			StandardIcons.listDrillDownAccessoryTexture = this.atlas.getTexture("list-accessory-drill-down-icon");*/

			/*this.setInitializerForClassAndSubclasses(Screen, screenInitializer); 
			this.setInitializerForClass(Label, labelInitializer);
			this.setInitializerForClass(ScrollText, scrollTextInitializer);
			this.setInitializerForClass(BitmapFontTextRenderer, itemRendererAccessoryLabelInitializer, BaseDefaultItemRenderer.DEFAULT_CHILD_NAME_ACCESSORY_LABEL);
			*/
			this.setInitializerForClass(Button, buttonInitializer);
			/*this.setInitializerForClass(Button, tabInitializer, TabBar.DEFAULT_CHILD_NAME_TAB);
			this.setInitializerForClass(Button, toggleSwitchOnTrackInitializer, ToggleSwitch.DEFAULT_CHILD_NAME_ON_TRACK);
			this.setInitializerForClass(Button, toggleSwitchThumbInitializer, ToggleSwitch.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, pickerListButtonInitializer, PickerList.DEFAULT_CHILD_NAME_BUTTON);
			this.setInitializerForClass(Button, stepperIncrementButtonInitializer, NumericStepper.DEFAULT_CHILD_NAME_INCREMENT_BUTTON);
			this.setInitializerForClass(Button, stepperDecrementButtonInitializer, NumericStepper.DEFAULT_CHILD_NAME_DECREMENT_BUTTON);
			this.setInitializerForClass(Button, nothingInitializer, SimpleScrollBar.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, nothingInitializer, ScrollBar.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, nothingInitializer, ScrollBar.DEFAULT_CHILD_NAME_DECREMENT_BUTTON);
			this.setInitializerForClass(Button, nothingInitializer, ScrollBar.DEFAULT_CHILD_NAME_INCREMENT_BUTTON);
			this.setInitializerForClass(Button, nothingInitializer, ScrollBar.DEFAULT_CHILD_NAME_MINIMUM_TRACK);
			this.setInitializerForClass(Button, nothingInitializer, ScrollBar.DEFAULT_CHILD_NAME_MAXIMUM_TRACK);
			this.setInitializerForClass(Button, nothingInitializer, Slider.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, nothingInitializer, Slider.DEFAULT_CHILD_NAME_MINIMUM_TRACK);
			this.setInitializerForClass(Button, nothingInitializer, Slider.DEFAULT_CHILD_NAME_MAXIMUM_TRACK);
			this.setInitializerForClass(ButtonGroup, buttonGroupInitializer);
			this.setInitializerForClass(Check, checkInitializer);
			this.setInitializerForClass(Radio, radioInitializer);
			this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
			this.setInitializerForClass(Slider, sliderInitializer);
			this.setInitializerForClass(NumericStepper, numericStepperInitializer);
			this.setInitializerForClass(SimpleScrollBar, simpleScrollBarInitializer);
			this.setInitializerForClass(ScrollBar, scrollBarInitializer);
			this.setInitializerForClass(TextInput, textInputInitializer);
			this.setInitializerForClass(TextInput, numericStepperTextInputInitializer, NumericStepper.DEFAULT_CHILD_NAME_TEXT_INPUT);
			this.setInitializerForClass(TextArea, textAreaInitializer);
			this.setInitializerForClass(PageIndicator, pageIndicatorInitializer);
			this.setInitializerForClass(ProgressBar, progressBarInitializer);
			this.setInitializerForClass(List, listInitializer);
			this.setInitializerForClass(List, pickerListListInitializer, PickerList.DEFAULT_CHILD_NAME_LIST);
			this.setInitializerForClass(GroupedList, groupedListInitializer);
			this.setInitializerForClass(PickerList, pickerListInitializer);
			this.setInitializerForClass(DefaultListItemRenderer, defaultItemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, defaultItemRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, defaultHeaderOrFooterRendererInitializer);
			this.setInitializerForClass(Header, headerInitializer);
			this.setInitializerForClass(Header, panelHeaderInitializer, Panel.DEFAULT_CHILD_NAME_HEADER);
			this.setInitializerForClass(Callout, calloutInitializer);
			this.setInitializerForClass(ScrollContainer, scrollContainerInitializer);
			this.setInitializerForClass(ScrollContainer, scrollContainerToolbarInitializer, ScrollContainer.ALTERNATE_NAME_TOOLBAR);
			this.setInitializerForClass(Panel, panelInitializer);*/
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