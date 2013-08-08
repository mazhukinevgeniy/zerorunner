package ui.mainMenu 
{
	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;
	import feathers.controls.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.display.Quad;
	import ui.ChaoticUI;
	import ui.WindowsFeature;
	import game.ZeroRunner;
	import utils.updates.IUpdateDispatcher;
	
	public class MainMenu  extends ScrollContainer
	{	
	
		public static const WIDTH_MAIN_MENU:Number = 150;
		public static const HEIGHT_MAIN_MENU:Number = 300;
		public static const WIDTH_BUTTON:Number = 120;
		public static const HEIGHT_BUTTON:Number = 30;
		
		private static const SPACE_BEETWEEN_BUTTON:Number = 25;
		private static const START_HEIGHT_BUTTONS:Number = 50;
		
		
		private var flow:IUpdateDispatcher;
		
		private var playButton:Button,
					statisticsButton:Button,
					achievementsButton:Button,
					creditsButton:Button;
		
		
		public function MainMenu(flow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.width = MainMenu.WIDTH_MAIN_MENU;
			this.height = MainMenu.HEIGHT_MAIN_MENU;
			
			this.initialiazationLayout();
			this.initializationButtons();
			
			this.flow = flow;
		}
		
		private function initialiazationLayout():void
		{
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = MainMenu.SPACE_BEETWEEN_BUTTON;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			
			this.layout = layout;
		}
		
		private function initializationButtons():void 
		{
			this.playButton = ButtonMainMenuFactory.create("New game");
			this.addChild(this.playButton);
			
			this.statisticsButton = ButtonMainMenuFactory.create("Statistics");
			this.addChild(this.statisticsButton);
			
			this.achievementsButton = ButtonMainMenuFactory.create("Achievements");
			this.addChild(this.achievementsButton);
			
			this.creditsButton = ButtonMainMenuFactory.create("Credits");
			this.addChild(this.creditsButton);
			
			this.playButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.statisticsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.achievementsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.creditsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
		}
		
		private function handleMenuTriggered(event:Event):void
		{
			if (event.target == this.playButton)
			{
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