package ui.mainMenu 
{
	import feathers.controls.Button;
	import ui.themes.ExtendedTheme;
	
	internal class ButtonMainMenuFactory
	{
		
		public static function create(title:String = "title" ):Button
		{
			var newButton:Button = new Button();
			newButton.nameList.add(ExtendedTheme.BUTTON_MAIN_MENU);
			
			newButton.width = MainMenu.WIDTH_BUTTON;
			newButton.height = MainMenu.HEIGHT_BUTTON;
			newButton.label = title;
			
			
			return newButton;
		}
		
	}

}