package ui.mainMenu 
{
	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;
	import feathers.controls.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.display.Quad;
	import ui.WindowsFeature;
	import game.ZeroRunner;
	import utils.updates.IUpdateDispatcher;
	
	public class MainMenu extends ScrollContainer
	{	
	
		public static const WIDTH_MAIN_MENU:Number = 150;
		public static const HEIGHT_MAIN_MENU:Number = 300;
		
		private static const SPACE_BEETWEEN_BUTTON:Number = 25;
		private static const START_HEIGHT_BUTTONS:Number = 50;
		
		
		protected var flow:IUpdateDispatcher;
		
		protected var playButton:Button,
					statisticsButton:Button,
					achievementsButton:Button,
					creditsButton:Button;
		
		//TODO: extract main navigation buttons into the special class to inhereit it with CompactMenu
		
		private var resetButton:Button;
		
		
		public function MainMenu(flow:IUpdateDispatcher) 
		{
			this.initializeSize();
			this.initializeLayout();
			this.initializeButtons();
			
			this.resetButton = ButtonMainMenuFactory.create("Reset progress");
			this.addChild(this.resetButton);
			
			this.resetButton.addEventListener(Event.TRIGGERED, this.handleResetTriggered);
			
			this.flow = flow;
		}
		
		protected function initializeSize():void
		{
			this.width = MainMenu.WIDTH_MAIN_MENU;
			this.height = MainMenu.HEIGHT_MAIN_MENU;
		}
		
		protected function initializeLayout():void
		{
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = MainMenu.SPACE_BEETWEEN_BUTTON;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			
			this.layout = layout;
		}
		
		protected function initializeButtons():void 
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
		
		protected function handleMenuTriggered(event:Event):void
		{
			if (event.target == this.playButton)
			{
				this.playButton.focusManager.focus = null;
				this.flow.dispatchUpdate(Update.newGame);
			}
			else if (event.target == this.statisticsButton)
			{
				this.flow.dispatchUpdate(Update.openWindow, WindowsFeature.STATISTICS);
			}
			else if (event.target == this.achievementsButton)
			{
				this.flow.dispatchUpdate(Update.openWindow, WindowsFeature.ACHIEVEMENTS);
			}
			else if (event.target == this.creditsButton)
			{
				this.flow.dispatchUpdate(Update.openWindow, WindowsFeature.CREDITS);
			}
		}
		
		private function handleResetTriggered():void
		{
			//TODO: tell about the risk. user 'll lose all his droids!
			
			this.flow.dispatchUpdate(Update.resetProgress);
		}
		
	}

}