package ui 
{
	import game.ZeroRunner;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import ui.background.Background;
	import ui.game.GameView;
	import ui.sounds.Sounds;
	import ui.WindowsFeature;
	import ui.themes.ExtendedTheme;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import utils.updates.update;
	import utils.updates.UpdateManager;
	
	public class ChaoticUI extends UpdateManager
	{
		public static const flowName:String = "Shell Flow";
		
		[Embed(source="../../res/assets/fonts/HiLoDeco.ttf", embedAsCFF="false", fontFamily="HiLo-Deco")]
		private static const HiLoDeco:Class;
		
		private var gameIsActive:Boolean;
		
		private var assets:AssetManager;
		private var root:DisplayObjectContainer;
		
		public function ChaoticUI(displayRoot:DisplayObjectContainer, assets:AssetManager) 
		{
			this.gameIsActive = false;
			this.assets = assets;
			
			super(ChaoticUI.flowName);
			
			this.initializationRootGUI(displayRoot);
		    this.initializationFeatures(displayRoot);
			this.initializationUsingFlow();
			
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function initializationRootGUI(displayRoot:DisplayObjectContainer):void
		{
			this.root = new Sprite();
			displayRoot.addChild(this.root);
		}
			
		private function initializationFeatures(displayRoot:DisplayObjectContainer):void
		{
			new ExtendedTheme(displayRoot);
			new Background(this.root);
			new GameView(displayRoot, this);
			new Sounds(this.root, this, this.assets);
			new WindowsFeature(this.root, this, this.assets);
		}
		
		private function initializationUsingFlow():void
		{
			this.workWithUpdateListener(this);
			this.addUpdateListener(Update.newGame);
			this.addUpdateListener(Update.keyUp);
			this.addUpdateListener(Update.quitGame);
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			this.dispatchUpdate(Update.keyUp, event.keyCode);
		}
		
		update function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.P && !this.gameIsActive)
			{
				this.dispatchUpdate(Update.newGame);
			}
		}
		
		update function newGame():void 
		{
			this.gameIsActive = true;
			
			this.root.visible = false;
			
			this.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, Update.newGame);
		}
		
		update function quitGame():void
		{
			this.root.visible = true;
		}
		
		
		
	}

}