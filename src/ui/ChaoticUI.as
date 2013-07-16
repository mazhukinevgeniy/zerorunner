package ui 
{
	import chaotic.core.UpdateManager;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import ui.background.Background;
	import ui.game.GameView;
	import ui.pauseControl.PauseTypes;
	import ui.sounds.Sounds;
	import ui.WindowsFeature;
	import ui.themes.ExtenedTheme;
	import ui.game.panel.Panel;
	import game.ZeroRunner;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	
	public class ChaoticUI extends UpdateManager
	{
		public static const flowName:String = "Shell Flow";
		public static const newGame:String = "newGame";
		
		public static const openWindow:String = "openWindow";
		
		
		public static const keyUp:String = "keyUp";
		
		[Embed(source="../../res/assets/fonts/HiLoDeco.ttf", embedAsCFF="false", fontFamily="HiLo-Deco")]
		private static const HiLoDeco:Class;
		
		private var gameIsActive:Boolean;
		
		private var assets:AssetManager;
		private var root:DisplayObjectContainer;
		
		public function ChaoticUI(displayRoot:DisplayObjectContainer, assets:AssetManager) 
		{
			this.gameIsActive = false;
			
			this.root = new Sprite();
			displayRoot.addChild(this.root);
			
			this.assets = assets;
			
			super(ChaoticUI.flowName);
			
		    new ExtenedTheme(displayRoot);
			
			new Background(this.root);
			new GameView(displayRoot, this);
			new Sounds(this.root, this, this.assets);
			
			new WindowsFeature(this.root, this, this.assets);
			
			new PauseTypes(this);
			
			this.workWithUpdateListener(this);
			this.addUpdateListener(ChaoticUI.newGame);
			this.addUpdateListener(ZeroRunner.gameOver);
			this.addUpdateListener(ZeroRunner.quitGame);
			this.addUpdateListener(ChaoticUI.keyUp);
			
			
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			this.dispatchUpdate(ChaoticUI.keyUp, event.keyCode);
		}
		
		public function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.P && !this.gameIsActive)
			{
				this.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, ChaoticUI.newGame);
				this.dispatchUpdate(ChaoticUI.newGame);
			}
		}
		
		public function newGame():void 
		{
			this.gameIsActive = true;
			
			this.root.visible = false;
		}
		
		public function gameOver():void
		{
			this.gameIsActive = false;
		}
		
		public function quitGame():void
		{
			this.root.visible = true;
			
			this.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, ZeroRunner.quitGame);
		}
		
		
		
	}

}