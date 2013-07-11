package ui.mainMenu 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.UpdateManager;
	import feathers.controls.Button;
	import game.ZeroRunner;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import ui.ChaoticUI;
	
	public class MainMenu extends WindowBase
	{		
		
		private var flow:IUpdateDispatcher;
		
		private var playButton:ButtonMainMenu;
		
		
		public function MainMenu(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			super(250, 150);
			
			this.playButton = new ButtonMainMenu(assets.getTexture("badbutton1"), "New game");
			this.addChild(this.playButton);
			
			this.playButton.addEventListener(Event.TRIGGERED, this.handlePlayTriggered);
			
			
			root.addChild(this);
			
			this.flow = flow;
		}
		
		
		private function handlePlayTriggered(event:Event):void
		{
			if (event.target == this.playButton)
			{
				this.flow.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, ChaoticUI.newGame);
				this.flow.dispatchUpdate(ChaoticUI.newGame);
			}
		}
	}

}