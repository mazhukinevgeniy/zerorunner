package view.game.factories 
{
	import feathers.controls.Button;
	import view.themes.GameTheme;
	
	public function createButton(title:String):Button
	{
		var button:Button = new Button();
		
		button.label = title;
		button.nameList.add(GameTheme.MENU_BUTTON);
		
		return button;
	}
	//TODO: merge with the other factory
	
}