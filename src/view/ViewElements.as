package view 
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.interfaces.INotifier;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import view.shell.initializeShell;
	import view.themes.GameTheme;
	
	public class ViewElements implements IDependent
	{
		private var shellRoot:Sprite;
		private var gameRoot:Sprite;
		
		public function ViewElements(binder:IBinder, root:DisplayObjectContainer) 
		{
			binder.requestBindingFor(this);
			
			
			var shellRoot:Sprite = new Sprite();
			var gameRoot:Sprite = new Sprite();
			
			root.addChild(shellRoot);
			root.addChild(gameRoot);
			
			gameRoot.visible = false;
			
			
			initializeShell(shellRoot);
			
			
			
			this.shellRoot = shellRoot;
			this.gameRoot = gameRoot;
		}
		
		public function bindObjects(binder:IBinder):void
		{
			var assetManager:AssetManager = binder.assetManager;
			
			new GameTheme(this.gameRoot, assetManager.getTextureAtlas("sprites"));
			
			
			
			var notifier:INotifier = binder.notifier;
			
			//TODO: observe newGame/quitGame
		}
		
	}

}