package ui 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.UpdateManager;
	import flash.events.KeyboardEvent;
	import game.ZeroRunner;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.utils.AssetManager;
	import ui.background.Background;
	import ui.game.GameView;
	import ui.pauseControl.PauseTypes;
	import ui.sounds.Sounds;
	import ui.WindowsFeature;
	import ui.themes.ExtenedTheme;
	import ui.game.panel.Panel;
	import flash.ui.Keyboard;
	
	public class ChaoticUI extends UpdateManager
	{
		public static const flowName:String = "Shell Flow";
		public static const newGame:String = "newGame";
		
		public static const openWindow:String = "openWindow";
		
		
		public static const keyUp:String = "keyUp";
		
		[Embed(source="../../res/assets/fonts/HiLoDeco.ttf", embedAsCFF="false", fontFamily="HiLo-Deco")]
		private static const HiLoDeco:Class;
		
		private static var gameRunToggled:Boolean;
		
		private var assets:AssetManager;
		private var root:DisplayObjectContainer;
		
		public function ChaoticUI(displayRoot:DisplayObjectContainer, assets:AssetManager) 
		{
			ChaoticUI.gameRunToggled = false;
			
			this.root = displayRoot;
			this.assets = assets;
			
			super(ChaoticUI.flowName);
			
		    new ExtenedTheme(root);
			
			new Background(this.root);
			new GameView(this.root, this);
			new Sounds(this.root, this, this.assets);
			
			new WindowsFeature(this.root, this, this.assets);
			
			new PauseTypes(this);
			
			this.workWithUpdateListener(this);
			this.addUpdateListener(ChaoticUI.newGame);
			this.addUpdateListener(Panel.panel_BackToMenu);
			this.addUpdateListener(ChaoticUI.keyUp);
			
			
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			this.dispatchUpdate(ChaoticUI.keyUp, event.keyCode);
		}
		
		public function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.P && !ChaoticUI.gameRun)
			{
				this.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, ChaoticUI.newGame);
				this.dispatchUpdate(ChaoticUI.newGame);
			}
		}
		
		public static function get gameRun():Boolean
		{
			return ChaoticUI.gameRunToggled;
		}
		
		public function newGame():void 
		{
			ChaoticUI.gameRunToggled = true;
		}
		
		public function panel_BackToMenu():void
		{
			ChaoticUI.gameRunToggled = false;
		}
		
		
		
		
	}

}