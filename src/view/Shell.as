package view 
{
	import data.IStatus;
	import game.GameElements;
	import starling.core.Starling;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import ui.background.Background;
	import ui.navigation.Navigation;
	import ui.sounds.Sounds;
	import ui.themes.Theme;
	import ui.Windows;
	import ui.themes.ExtendedTheme;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	import utils.updates.UpdateManager;
	
	public class Shell
	{
		private var status:IStatus;
		
		private var assets:AssetManager;
		
		private var background:Background,
					windows:Windows,
					navigation:Navigation;
		
		private var flow:IUpdateDispatcher;
		
		private var ownRoot:DisplayObjectContainer;
		
		public function Shell(globalDisplayRoot:DisplayObjectContainer, elements:GameElements)
		{
			this.status = elements.status;
			
			this.flow = elements.flow;
			this.assets = elements.assets;
			
			this.ownRoot = new Sprite();
			globalDisplayRoot.addChild(ownRoot);
			
		    this.initializeFeatures(elements);
			this.initializeUsingFlow();
		}
		
		private function initializeFeatures(elements:GameElements):void
		{
			new Theme(elements, this.ownRoot);
			
			this.background = new Background();
			this.navigation = new Navigation(elements);
			this.windows = new Windows(elements)
			
			new Sounds(elements);
			
			this.ownRoot.addChild(this.background);
			this.ownRoot.addChild(this.windows);
			this.ownRoot.addChild(this.navigation);
		}
		
		private function initializeUsingFlow():void 
		{
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.newGame);
			this.flow.addUpdateListener(Update.quitGame);
		}
		
		update function newGame():void 
		{
			this.ownRoot.visible = false;
		}
		
		update function quitGame():void
		{
			this.ownRoot.visible = true;
		}
		
		
		
	}

}