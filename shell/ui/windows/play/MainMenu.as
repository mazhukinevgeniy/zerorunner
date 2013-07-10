package ui.windows.play 
{
	import feathers.controls.Button;
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
					
					//====
		private var button:Button;
		
		public function MainMenu(assets:AssetManager) 
		{
			super(250, 150);
			
			this.playButton = new ButtonMainMenu(assets.getTexture("badbutton1"), "New game");
			this.addChild(this.playButton);
			
			this.addEventListener(Event.TRIGGERED, this.handleTrigger);
			
			
			//===
			this.button = new Button();
			this.button.label = "Test";
			this.button.x = 0;
			this.button.y = 0;
			this.addChild(this.button);
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