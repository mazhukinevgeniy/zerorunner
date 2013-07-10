package ui 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.UpdateManager;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import ui.background.Background;
	import ui.game.GameView;
	import ui.mainMenu.MainMenu;
	import ui.pauseControl.PauseTypes;
	import ui.sounds.Sounds;
	
	public class ChaoticUI extends UpdateManager
	{
		public static const flowName:String = "Shell Flow";
		public static const newGame:String = "newGame";
		
		
		public static const keyUp:String = "keyUp";
		
		[Embed(source="../../res/assets/fonts/HiLoDeco.ttf", embedAsCFF="false", fontFamily="HiLo-Deco")]
		private static const HiLoDeco:Class;
		
		
		private var assets:AssetManager;
		private var root:DisplayObjectContainer;
		
		public function ChaoticUI(displayRoot:DisplayObjectContainer, assets:AssetManager) 
		{
			this.root = displayRoot;
			this.assets = assets;
			
			super(ChaoticUI.flowName);
			
			new Background(this.root);
			new MainMenu(this.root, this, assets);
			new GameView(this.root, this);
			new Sounds(this.root, this, this.assets);
			
			//new PauseTypes(this); //TODO: uncomment
		}
	}

}