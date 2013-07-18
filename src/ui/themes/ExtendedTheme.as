package ui.themes 
{
	import feathers.controls.Label;
	import starling.display.DisplayObjectContainer;
	import feathers.controls.Button;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	
	public class ExtendedTheme extends AeonDesktopTheme
	{
		public static const BUTTON_MAIN_MENU:String = "button-main-menu";
		public static const TITLE_STATICTICS_PIECE:String = "title-statistics-piece";
		
		private static const DEFAULT_TEXT_FORMAT:TextFormat = new TextFormat("HiLo-Deco", 18, AeonDesktopTheme.PRIMARY_TEXT_COLOR, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
		private static const DISABLE_TEXT_FORMAT:TextFormat = new TextFormat("HiLo-Deco", 18, AeonDesktopTheme.DISABLED_TEXT_COLOR, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
		
		public function ExtendedTheme(root:DisplayObjectContainer)
		{
			super(root);
		} 
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.defaultTextFormat = ExtendedTheme.DEFAULT_TEXT_FORMAT;
			this.disabledTextFormat = ExtendedTheme.DISABLE_TEXT_FORMAT;
			
			this.setInitializerForClass( Button, this.buttonMainMenu, ExtendedTheme.BUTTON_MAIN_MENU );
			this.setInitializerForClass( Label, this.titleStatisticsPiece, ExtendedTheme.TITLE_STATICTICS_PIECE);
		}
		
		private function buttonMainMenu(button:Button):void
		{
			this.buttonInitializer(button);
			
			button.defaultLabelProperties.embedFonts = true;
		}
		
		private function titleStatisticsPiece (label:Label):void
		{
			this.labelInitializer(label);
			
			label.textRendererProperties.embedFonts = true;
			label.textRendererProperties.textFormat = new TextFormat("HiLo-Deco", 20, AeonDesktopTheme.PRIMARY_TEXT_COLOR, true, false, false, null, null, TextFormatAlign.CENTER, 0, 0, 0, 0);
		}
	}

}