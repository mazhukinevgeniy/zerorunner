package ui.themes 
{
	import feathers.controls.Label;
	import starling.display.DisplayObjectContainer;
	import feathers.controls.Button;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	
	public class ExtendedTheme extends AeonDesktopTheme
	{
		public static const BUTTON_MENU:String = "button-menu";
		public static const MUTE_BUTTON:String = "mute-button";
		public static const TITLE_STATICTICS_PIECE:String = "title-statistics-piece";
		public static const BUTTON_STATISTICS_ROLL:String = "button-statistics-roll";
		public static const BUTTON_STATISTICS_FIX:String = "button-statistics-fix";
		
		private static const DEFAULT_TEXT_FORMAT:TextFormat = new TextFormat("HiLo-Deco", 18, AeonDesktopTheme.PRIMARY_TEXT_COLOR, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
		private static const DISABLE_TEXT_FORMAT:TextFormat = new TextFormat("HiLo-Deco", 18, AeonDesktopTheme.DISABLED_TEXT_COLOR, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
		
		private static const STATISTICS_TITLE_TEXT_FORMAT:TextFormat = new TextFormat("HiLo-Deco", 20, AeonDesktopTheme.PRIMARY_TEXT_COLOR, true, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
		
		private static const SIZE_STATISTICS_BUTTON:Number = 15;
		
		private static const MUTE_BUTTON_WIDTH:int = 80;
		private static const MUTE_BUTTON_HEIGHT:int = 20;
		
		public function ExtendedTheme(root:DisplayObjectContainer)
		{
			super(root);
		} 
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.defaultTextFormat = ExtendedTheme.DEFAULT_TEXT_FORMAT;
			this.disabledTextFormat = ExtendedTheme.DISABLE_TEXT_FORMAT;
			
			this.setNewInitializersForClasses();
		}
		
		private function setNewInitializersForClasses():void
		{
			this.setInitializerForClass( Button, this.buttonMenu, ExtendedTheme.BUTTON_MENU );
			this.setInitializerForClass( Button, this.muteButton, ExtendedTheme.MUTE_BUTTON );
			this.setInitializerForClass( Button, this.buttonStatisticsRoll, ExtendedTheme.BUTTON_STATISTICS_ROLL);
			this.setInitializerForClass( Button, this.buttonStatisticsFix, ExtendedTheme.BUTTON_STATISTICS_FIX);
			
			this.setInitializerForClass( Label, this.titleStatisticsPiece, ExtendedTheme.TITLE_STATICTICS_PIECE);
		}
		
		private function buttonMenu(button:Button):void
		{
			this.buttonInitializer(button);
			
			button.defaultLabelProperties.embedFonts = true;
		}
		
		private function muteButton(button:Button):void
		{
			this.buttonInitializer(button);
			
			button.defaultLabelProperties.embedFonts = true;
			button.label = "Mute";
			button.width = ExtendedTheme.MUTE_BUTTON_WIDTH;
			button.height = ExtendedTheme.MUTE_BUTTON_HEIGHT;
		}
		
		private function buttonStatisticsRoll(button:Button):void
		{
			this.buttonInitializer(button);
			
			button.width = ExtendedTheme.SIZE_STATISTICS_BUTTON;
			button.height = ExtendedTheme.SIZE_STATISTICS_BUTTON;
		}
		
		private function buttonStatisticsFix(button:Button):void
		{
			this.buttonInitializer(button);
			
			button.width = ExtendedTheme.SIZE_STATISTICS_BUTTON;
			button.height = ExtendedTheme.SIZE_STATISTICS_BUTTON;
		}
		
		private function titleStatisticsPiece (label:Label):void
		{
			this.labelInitializer(label);
			
			label.textRendererProperties.embedFonts = true;
			label.textRendererProperties.textFormat = ExtendedTheme.STATISTICS_TITLE_TEXT_FORMAT;
		}
	}

}