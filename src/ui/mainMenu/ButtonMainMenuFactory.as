package ui.mainMenu 
{
	import feathers.controls.Button;
	import ui.themes.ExtenedTheme;
	
	internal class ButtonMainMenuFactory
	{
		
		public static function create(title:String = "title" ):Button
		{
			var newButton:Button = new Button();
			newButton.nameList.add(ExtenedTheme.BUTTON_MAIN_MENU);
			
			newButton.width = MainMenu.WIDTH_BUTTON;
			newButton.height = MainMenu.HEIGHT_BUTTON;
			newButton.label = title;
			
			
			return newButton;
		}
		
	}

}