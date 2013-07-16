package ui.mainMenu 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.UpdateManager;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.display.Quad;
	import ui.ChaoticUI;
	import ui.WindowsFeature;
	import feathers.controls.Button;
	import game.ZeroRunner;
	
	public class MainMenu  extends Sprite
	{	
	
		public static const WIDTH_MAIN_MENU:Number = 150;
		public static const HEIGHT_MAIN_MENU:Number = 300;
		public static const WIDTH_BUTTON:Number = 120;
		public static const HEIGHT_BUTTON:Number = 30;
		
		private static const SPACE_BEETWEEN_BUTTON:Number = 20;
		private static const START_HEIGHT_BUTTONS:Number = 50;
		
		
		private var flow:IUpdateDispatcher;
		
		private var playButton:Button,
					statisticsButton:Button,
					achievementsButton:Button,
					creditsButton:Button;
		
		
		public function MainMenu( flow:IUpdateDispatcher, assets:AssetManager, name:String = "MainMenu") 
		{			
			this.name = name;
			
			var tmp:Quad = new Quad(MainMenu.WIDTH_MAIN_MENU, MainMenu.HEIGHT_MAIN_MENU, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
			this.playButton = ButtonMainMenuFactory.create(MainMenu.START_HEIGHT_BUTTONS, "New game");
			this.addChild(this.playButton);
			
			this.statisticsButton = ButtonMainMenuFactory.create(MainMenu.START_HEIGHT_BUTTONS + MainMenu.HEIGHT_BUTTON + MainMenu.SPACE_BEETWEEN_BUTTON,
													   "Statistics");
			this.addChild(this.statisticsButton);
			
			this.achievementsButton = ButtonMainMenuFactory.create(MainMenu.START_HEIGHT_BUTTONS + 2 * MainMenu.HEIGHT_BUTTON + 2 * MainMenu.SPACE_BEETWEEN_BUTTON,
													   "Achievements");
			this.addChild(this.achievementsButton);
			
			this.creditsButton = ButtonMainMenuFactory.create(MainMenu.START_HEIGHT_BUTTONS + 3 * MainMenu.HEIGHT_BUTTON + 3 * MainMenu.SPACE_BEETWEEN_BUTTON,
													   "Credits");
			this.addChild(this.creditsButton);

			
			this.playButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.statisticsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.achievementsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.creditsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			
			this.flow = flow;
		}
		
		private function handleMenuTriggered(event:Event):void
		{
			if (event.target == this.playButton)
			{
				this.flow.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, ChaoticUI.newGame);
				this.flow.dispatchUpdate(ChaoticUI.newGame);
			}
			else if (event.target == this.statisticsButton)
			{
				this.flow.dispatchUpdate(ChaoticUI.openWindow, WindowsFeature.STATISTICS);
			}
			else if (event.target == this.achievementsButton)
			{
				this.flow.dispatchUpdate(ChaoticUI.openWindow, WindowsFeature.ACHIEVEMENTS);
			}
			else if (event.target == this.creditsButton)
			{
				this.flow.dispatchUpdate(ChaoticUI.openWindow, WindowsFeature.CREDITS);
			}
		}
		
		
	}

}