package ui.themes 
{
	import feathers.controls.Label;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.ITextRenderer;
	import flash.text.TextFormat;
	import starling.display.DisplayObjectContainer;
	import feathers.controls.Button;
	import starling.textures.Texture;
	import starling.display.Image;
	import feathers.display.Scale9Image;
	import flash.text.TextFormatAlign;
	
	public class ExtenedTheme extends AeonDesktopTheme
	{
		public static const BUTTON_MAIN_MENU:String = "button-main-menu";
		
		public function ExtenedTheme(root:DisplayObjectContainer)
		{
			super(root);
		} 
		
		override protected function initialize():void
		{
			super.initialize();
			
			this.defaultTextFormat = new TextFormat("HiLo-Deco", 18, PRIMARY_TEXT_COLOR, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
			this.disabledTextFormat = new TextFormat("HiLo-Deco", 18, DISABLED_TEXT_COLOR, false, false, false, null, null, TextFormatAlign.LEFT, 0, 0, 0, 0);
			
			this.setInitializerForClass( Button, this.buttonMainMenu, ExtenedTheme.BUTTON_MAIN_MENU );
		}
		
		private function buttonMainMenu(button:Button):void
		{
			this.buttonInitializer(button);
			
			button.defaultLabelProperties.embedFonts = true;
		}
	}

}