package view 
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.interfaces.INotifier;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import view.game.initializeGameView;
	import view.shell.initializeShell;
	import view.themes.GameTheme;
	import view.themes.ShellTheme;
	
	public class ViewElements implements IDependent
	{
		private var shellRoot:Sprite;
		private var gameRoot:Sprite;
		
		public function ViewElements(binder:IBinder, root:DisplayObjectContainer) 
		{
			binder.requestBindingFor(this);
			
			this.createRoots(root);
			this.bindAssets(binder);
			
			initializeShell(this.shellRoot);
			initializeGameView(this.gameRoot);
		}
		
		private function createRoots(root:DisplayObjectContainer):void
		{
			var shellRoot:Sprite = new Sprite();
			var gameRoot:Sprite = new Sprite();
			
			root.addChild(shellRoot);
			root.addChild(gameRoot);
			
			gameRoot.visible = false;
			
			this.shellRoot = shellRoot;
			this.gameRoot = gameRoot;
		}
		
		private function bindAssets(binder:IBinder):void
		{
			var assetManager:AssetManager = binder.assetManager;
			var sprites:TextureAtlas = assetManager.getTextureAtlas("sprites");
			
			new GameTheme(this.gameRoot, sprites);
			new ShellTheme(this.shellRoot, sprites);
		}
		
		public function bindObjects(binder:IBinder):void
		{
			var notifier:INotifier = binder.notifier;
			
			//TODO: observe newGame/quitGame
		}
		
	}

}