package ui 
{
	import progress.ProgressManager;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import ui.background.Background;
	import ui.navigation.Navigation;
	import ui.sounds.Sounds;
	import ui.WindowsFeature;
	import ui.themes.ExtendedTheme;
	import flash.ui.Keyboard;
	import flash.events.KeyboardEvent;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	import utils.updates.UpdateManager;
	
	public class Shell
	{		
		private var gameIsActive:Boolean;
		
		private var assets:AssetManager;
		private var root:DisplayObjectContainer;
		
		private var flow:IUpdateDispatcher;
		
		public function Shell(flow:IUpdateDispatcher, displayRoot:DisplayObjectContainer, assets:AssetManager, progress:ProgressManager) 
		{
			this.flow = flow;
			
			this.gameIsActive = false;
			this.assets = assets;
			
			this.initializationRootGUI(displayRoot);
		    this.initializationFeatures(displayRoot);
			this.initializationUsingFlow();
			
			Starling.current.nativeStage.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function initializationRootGUI(displayRoot:DisplayObjectContainer):void
		{
			this.root = displayRoot;
		}
			
		private function initializationFeatures(displayRoot:DisplayObjectContainer):void
		{
			new ExtendedTheme(this.root);
			new Background(this.root);
			//new GameView(displayRoot, this.flow);
			new Navigation(this.root, this.flow);
			new Sounds(this.root, this.flow, this.assets);
			new WindowsFeature(this.root, this.flow, this.assets);
		}
		
		private function initializationUsingFlow():void 
		{
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.newGame);
			this.flow.addUpdateListener(Update.keyUp);
			this.flow.addUpdateListener(Update.quitGame);
		}
		//TODO: rename all the methods: initialization -> initialize
		
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
			this.gameIsActive = true;
			
			this.root.visible = false;
		}
		
		update function quitGame():void
		{
			this.gameIsActive = false;
			
			this.root.visible = true;
		}
		
		
		
	}

}