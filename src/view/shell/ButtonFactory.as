package view.shell 
{
	import feathers.controls.Button;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import view.themes.ShellTheme;
	
	internal class ButtonFactory 
	{
		private var assets:AssetManager;
		
		private var defaultWidth:Number,
					defaultHeight:Number;
					
		private var background:String;
		
		public function ButtonFactory(assets:AssetManager, defaultWidth:Number, defaultHeight:Number)
		{
				this.assets = assets;
				this.defaultHeight = defaultHeight;
				this.defaultWidth = defaultWidth;
				this.background = background;
		}
		
		public function createButton(title:String):Button
		{
				var button:Button = new Button();
				
				button.width = this.defaultWidth;
				button.height = this.defaultHeight;
				button.label = title;
				
				button.nameList.add(ShellTheme.NAVIGATION_BUTTON);
				
				return button;
		}
		
	}

}