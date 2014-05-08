package view 
{
	import binding.IBinder;
	import controller.interfaces.INotifier;
	import controller.observers.game.INewGameHandler;
	import controller.observers.game.IQuitGameHandler;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import view.game.initializeGameView;
	import view.shell.initializeShell;
	import view.sounds.Sounds;
	import view.themes.GameTheme;
	import view.themes.ShellTheme;
	
	public class ViewElements implements INewGameHandler, IQuitGameHandler
	{
		private var shellRoot:Sprite;
		private var gameRoot:Sprite;
		
		public function ViewElements(binder:IBinder, root:DisplayObjectContainer) 
		{
			binder.notifier.addGameStatusObserver(this);
			
			this.createRoots(root);
			this.bindAssets(binder);
			
			initializeShell(this.shellRoot, this.gameRoot, binder);
			initializeGameView(binder, this.gameRoot);
			
			new Sounds(binder);
			new EventListener(binder, Starling.current.nativeStage);
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
		
		public function newGame():void
		{
			this.shellRoot.visible = false;
		}
		
		public function quitGame():void
		{
			this.shellRoot.visible = true;
		}
		
	}

}