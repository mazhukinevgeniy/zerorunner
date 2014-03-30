package ui.navigation 
{
	import feathers.controls.Button;
	import ui.themes.ExtendedTheme;
	
	internal class ButtonMenuFactory
	{
		private static const WIDTH_BUTTON_MENU:Number = 120;
		private static const HEIGHT_BUTTON_MENU:Number = 30;
		private static const SIZE_BUTTON_COMPACT_MENU:Number = 35;
		
		public static function create(title:String = "title", compactSize:Boolean = false):Button
		{
			var newButton:Button = new Button();
			
			if (!compactSize)
			{
				newButton.width = ButtonMenuFactory.WIDTH_BUTTON_MENU;
				newButton.height = ButtonMenuFactory.HEIGHT_BUTTON_MENU;
			}
			else
			{
				newButton.width = ButtonMenuFactory.SIZE_BUTTON_COMPACT_MENU;
				newButton.height = ButtonMenuFactory.SIZE_BUTTON_COMPACT_MENU;
			}
			
			newButton.label = title;
			
			
			return newButton;
		}
		
	}

}