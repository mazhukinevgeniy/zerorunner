package ui.mainMenu 
{
	import feathers.controls.Button;
	import ui.themes.ExtendedTheme;
	
	internal class ButtonMainMenuFactory
	{
		private static const WIDTH_BUTTON_MAIN_MENU:Number = 120;
		private static const HEIGHT_BUTTON_MAIN_MENU:Number = 30;
		private static const SIZE_BUTTON_COMPACT_MENU:Number = 35;
		
		public static function create(title:String = "title", compactSize:Boolean = false):Button
		{
			var newButton:Button = new Button();
			newButton.nameList.add(ExtendedTheme.BUTTON_MAIN_MENU);
			
			if (!compactSize)
			{
				newButton.width = ButtonMainMenuFactory.WIDTH_BUTTON_MAIN_MENU;
				newButton.height = ButtonMainMenuFactory.HEIGHT_BUTTON_MAIN_MENU;
			}
			else
			{
				newButton.width = ButtonMainMenuFactory.SIZE_BUTTON_COMPACT_MENU;
				newButton.height = ButtonMainMenuFactory.SIZE_BUTTON_COMPACT_MENU;
			}
			
			newButton.label = title;
			
			
			return newButton;
		}
		
	}

}