package view.shell 
{
	import feathers.controls.Button;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import view.themes.ShellTheme;
	
	internal class ButtonFactory 
	{
		private var assets:AssetManager;
		
		public function ButtonFactory(assets:AssetManager)
		{
			this.assets = assets;
		}
		
		public function createButton(title:String):Button
		{
			var button:Button = new Button();
			
			button.label = title;
			
			button.nameList.add(ShellTheme.NAVIGATION_BUTTON);
			
			return button;
		}
		//TODO: reimplement via theme
	}

}