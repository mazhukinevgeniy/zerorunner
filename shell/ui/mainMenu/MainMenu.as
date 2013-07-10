package ui.mainMenu 
{
	import chaotic.core.IUpdateDispatcher;
	import feathers.controls.Button;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	public class MainMenu extends WindowBase
	{
		public static const mainMenu_NewGame:String = "mainMenu_NewGame";
		
		
		private var flow:IUpdateDispatcher;
		
		private var playButton:ButtonMainMenu;
		
		
		public function MainMenu(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			super(250, 150);
			
			this.playButton = new ButtonMainMenu(assets.getTexture("badbutton1"), "New game");
			this.addChild(this.playButton);
			
			this.playButton.addEventListener(Event.TRIGGERED, this.handlePlayTriggered);
			
			
			root.addChild(this);
		}
		
		
		private function handlePlayTriggered(event:Event):void
		{
			if (event.target == this.playButton)
			{
				this.flow.dispatchUpdate(MainMenu.mainMenu_NewGame);
			}
		}
	}

}