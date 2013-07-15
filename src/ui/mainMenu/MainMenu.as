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
	import ui.WindowsFeature;
	import starling.display.Sprite;
	import starling.display.Quad;
	import ui.game.panel.Panel;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	public class MainMenu  extends Sprite
	{	
	
		public static const WIDTH_MAIN_MENU:Number = 150;
		public static const HEIGHT_MAIN_MENU:Number = 300;
		public static const WIDTH_BUTTON:Number = 100;
		public static const HEIGHT_BUTTON:Number = 30;
		
		private static const SPACE_BEETWEEN_BUTTON:Number = 20;
		private static const START_HEIGHT_BUTTONS:Number = 50;
		
		
		private var flow:IUpdateDispatcher;
		
		private var playButton:ButtonMainMenu,
					statisticsButton:ButtonMainMenu,
					achievementsButton:ButtonMainMenu,
					creditsButton:ButtonMainMenu;
		
		
		public function MainMenu( flow:IUpdateDispatcher, assets:AssetManager, name:String = "MainMenu") 
		{
			this.name = WindowsFeature.MENU;
			
			var tmp:Quad = new Quad(MainMenu.WIDTH_MAIN_MENU, MainMenu.HEIGHT_MAIN_MENU, 0xFFFFFF);
			tmp.alpha = 0.85;
			this.addChild(tmp);
			
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

			
			this.playButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.statisticsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.achievementsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.creditsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			
			this.flow = flow;
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Panel.panel_BackToMenu);
		}
		
		public function panel_BackToMenu():void
		{
			this.visible = true;
		}
		
		private function handleMenuTriggered(event:Event):void
		{
			if (event.target == this.playButton)
			{
				this.flow.dispatchUpdate(ChaoticUI.openWindow, WindowsFeature.GAME);
				this.flow.dispatchUpdate(UpdateManager.callExternalFlow, ZeroRunner.flowName, ChaoticUI.newGame);
				this.flow.dispatchUpdate(ChaoticUI.newGame);
				this.visible = false;
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