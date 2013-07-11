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
	import ui.windows.WindowBase;
	
	public class MainMenu extends WindowBase
	{		
		
		private static const WIDTH_MAIN_MENU:Number = 250;
		private static const HEIGHT_MAIN_MENU:Number = 300;
		private static const SPACE_BEETWEEN_BUTTON:Number = 20;
		private static const START_HEIGHT_BUTTONS:Number = 50;
		
		
		public static const WIDTH_BUTTON:Number = 100;
		public static const HEIGHT_BUTTON:Number = 30;
		
		private var flow:IUpdateDispatcher;
		
		private var playButton:ButtonMainMenu,
					statisticsButton:ButtonMainMenu,
					achievementsButton:ButtonMainMenu,
					creditsButton:ButtonMainMenu;
		
		
		public function MainMenu(root:DisplayObjectContainer, flow:IUpdateDispatcher, assets:AssetManager) 
		{
			super(MainMenu.WIDTH_MAIN_MENU, MainMenu.HEIGHT_MAIN_MENU);
			
			this.playButton = new ButtonMainMenu(MainMenu.START_HEIGHT_BUTTONS, "New game");
			this.addChild(this.playButton);
			
			this.statisticsButton = new ButtonMainMenu(MainMenu.START_HEIGHT_BUTTONS + MainMenu.HEIGHT_BUTTON + MainMenu.SPACE_BEETWEEN_BUTTON,
													   "Statistics");
			this.addChild(this.statisticsButton);
			
			this.achievementsButton = new ButtonMainMenu(MainMenu.START_HEIGHT_BUTTONS + 2 * MainMenu.HEIGHT_BUTTON + 2 * MainMenu.SPACE_BEETWEEN_BUTTON,
													   "Achievements");
			this.addChild(this.achievementsButton);
			
			this.creditsButton = new ButtonMainMenu(MainMenu.START_HEIGHT_BUTTONS + 3 * MainMenu.HEIGHT_BUTTON + 3 * MainMenu.SPACE_BEETWEEN_BUTTON,
													   "Credits");
			this.addChild(this.creditsButton);

			
			this.playButton.addEventListener(Event.TRIGGERED, this.handlePlayTriggered);
			this.statisticsButton.addEventListener(Event.TRIGGERED, this.handleStatisticsTriggered);
			
			
			
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
		
		private function handleStatisticsTriggered(event:Event):void
		{
			if (event.target == this.statisticsButton)
			{
				this.flow.dispatchUpdate(ChaoticUI.changeShowStatistic);
			}
		}
	}

}