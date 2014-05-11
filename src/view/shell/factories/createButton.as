package view.shell.factories 
{
	import feathers.controls.Button;
	import view.themes.ShellTheme;
	
	public function createButton(title:String):Button
	{
		var button:Button = new Button();
		
		button.label = title;
		button.nameList.add(ShellTheme.NAVIGATION_BUTTON);
		
		return button;
	}
	
}