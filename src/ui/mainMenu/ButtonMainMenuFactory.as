package ui.mainMenu 
{
	import feathers.controls.Button;
	import ui.themes.ExtenedTheme;
	
	internal class ButtonMainMenuFactory
	{
		
		public static function create(y:Number = 0, title:String = "title" ):Button
		{
			var newButton:Button = new Button();
			newButton.nameList.add(ExtenedTheme.BUTTON_MAIN_MENU);
			
			newButton.width = MainMenu.WIDTH_BUTTON;
			newButton.height = MainMenu.HEIGHT_BUTTON;
			newButton.label = title;
			newButton.y = y;
			newButton.x = MainMenu.WIDTH_MAIN_MENU / 2 - newButton.width / 2;
			
			
			return newButton;
		}
		
	}

}