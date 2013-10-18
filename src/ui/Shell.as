package ui 
{
	import data.DatabaseManager;
	import data.StatusReporter;
	import game.core.GameFoundations;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
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
		private var status:StatusReporter;
		
		private var assets:AssetManager;
		
		private var background:Background,
					windows:Windows,
					navigation:Navigation;
		
		private var flow:IUpdateDispatcher;
		
		public function Shell(displayRoot:DisplayObjectContainer, 
							database:DatabaseManager, foundations:GameFoundations)
							//TODO: check what can be not passed; think if we need another parameter struct 
		{
			this.status = database.status;
			
			this.flow = foundations.flow;
			this.assets = foundations.assets;
			
		    this.initializeFeatures(displayRoot, foundations.displayRoot, database);
			this.initializeUsingFlow();
			
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function initializeFeatures(ownRoot:DisplayObjectContainer, gameRoot:DisplayObjectContainer, database:DatabaseManager):void
		{
			new ExtendedTheme(ownRoot);
			
			this.background = new Background(this.flow);
			this.navigation = new Navigation(this.flow, database.preferences);
			this.windows = new Windows(this.flow, this.assets, database, gameRoot)
			
			ownRoot.addChild(this.background);
			ownRoot.addChild(this.windows);
			ownRoot.addChild(this.navigation);
			
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
			if (keyCode == Keyboard.P && !this.status.isGameOn)
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