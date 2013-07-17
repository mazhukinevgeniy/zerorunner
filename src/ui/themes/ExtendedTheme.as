package ui.themes 
{
	import starling.display.DisplayObjectContainer;
	import feathers.controls.Button;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	
	public class ExtendedTheme extends AeonDesktopTheme
	{
		public static const BUTTON_MAIN_MENU:String = "button-main-menu";
		
		public function ExtendedTheme(root:DisplayObjectContainer)
		{
			super(root);
		} 
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.defaultTextFormat = new TextFormat("HiLo-Deco", 18, PRIMARY_TEXT_COLOR, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
			this.disabledTextFormat = new TextFormat("HiLo-Deco", 18, DISABLED_TEXT_COLOR, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
			
			this.setInitializerForClass( Button, this.buttonMainMenu, ExtendedTheme.BUTTON_MAIN_MENU );
		}
		
		private function buttonMainMenu(button:Button):void
		{
			this.buttonInitializer(button);
			
			button.defaultLabelProperties.embedFonts = true;
		}
	}

}