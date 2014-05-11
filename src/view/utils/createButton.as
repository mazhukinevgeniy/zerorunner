package view.utils 
{
	import feathers.controls.Button;
	import view.themes.ShellTheme;
	
	public function createButton(title:String, name:String):Button
	{
		var button:Button = new Button();
		
		button.label = title;
		button.nameList.add(name);
		
		return button;
	}
	
}