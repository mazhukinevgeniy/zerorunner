package ui 
{
	import data.DatabaseManager;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import ui.background.Background;
	import ui.navigation.Navigation;
	import ui.sounds.Sounds;
	import ui.Windows;
	import ui.themes.ExtendedTheme;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	import utils.updates.UpdateManager;
	
	public class Shell
	{		
		
		private var assets:AssetManager;
		private var root:DisplayObjectContainer;
		
		private var background:Background,
					windows:Windows,
					navigation:Navigation;
		
		private var flow:IUpdateDispatcher;
		
		public function Shell(flow:IUpdateDispatcher, displayRoot:DisplayObjectContainer, 
							assets:AssetManager, database:DatabaseManager, gameRoot:Sprite, ) 
		{
			this.flow = flow;
			this.assets = assets;
			
			this.root = displayRoot;
			
		    this.initializeFeatures(gameRoot, database);
			this.initializeUsingFlow();
			
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function initializeFeatures(gameRoot:Sprite, database:DatabaseManager):void
		{
			new ExtendedTheme(this.root);
			
			this.background = new Background(this.flow);
			this.navigation = new Navigation(this.flow);
			this.windows = new Windows(this.flow, this.assets, database, gameRoot)
			
			this.root.addChild(this.background);
			this.root.addChild(this.windows);
			this.root.addChild(this.navigation);
			
			new Sounds(this.flow, this.assets, database.preferences);
		}
		
		private function initializeUsingFlow():void 
		{
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.newGame);
			this.flow.addUpdateListener(Update.keyUp);
			this.flow.addUpdateListener(Update.quitGame);
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			this.flow.dispatchUpdate(Update.keyUp, event.keyCode);
		}
		
		update function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.P && !this.gameIsActive)
			{
				this.flow.dispatchUpdate(Update.newGame);
			}
		}
		
		update function newGame():void 
		{
			this.background.visible = false;
		}
		
		update function quitGame():void
		{
			this.background.visible = true;
		}
		
		
		
	}

}