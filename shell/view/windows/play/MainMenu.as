package view.windows.play 
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	
	import view.events.MainMenuEvent;
	import view.windows.WindowBase;
	
	public class MainMenu extends WindowBase
	{
		private var playButton:ButtonMainMenu,
					continueButton:ButtonMainMenu,
		            savefileButton:ButtonMainMenu;
		
		public function MainMenu(assets:AssetManager) 
		{
			super(250, 150);
			
			this.playButton = new ButtonMainMenu(assets.getTexture("badbutton1"), "New game");
			this.addChild(this.playButton);
			
			this.addEventListener(Event.TRIGGERED, this.handleTrigger);
		}
		
		
		private function handleTrigger(event:Event):void
		{
			if (event.target == this.playButton)
			{
				this.dispatchEvent(new MainMenuEvent(MainMenuEvent.NEW_GAME));
			}
		}
		
		override protected function closeYourself(event:Event):void
		{
			this.dispatchEvent(new MainMenuEvent(MainMenuEvent.CLOSE));
		}
	}

}