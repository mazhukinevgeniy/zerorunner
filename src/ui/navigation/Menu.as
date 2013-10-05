package ui.navigation 
{
	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;
	import feathers.controls.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import starling.display.Quad;
	import ui.Windows;
	import game.ZeroRunner;
	import utils.updates.IUpdateDispatcher;
	
	internal class Menu extends ScrollContainer
	{
		
		public static const WIDTH_MENU:Number = 150;
		public static const HEIGHT_MENU:Number = 300;
		
		private static const SPACE_BEETWEEN_BUTTON:Number = 25;
		private static const START_HEIGHT_BUTTONS:Number = 50;
		
		
		protected var flow:IUpdateDispatcher;
		
		protected var playButton:Button,
					statisticsButton:Button,
					achievementsButton:Button,
					creditsButton:Button;
		
		//TODO: extract main navigation buttons into the special class to inhereit it with CompactMenu
		
		private var resetButton:Button;
		
		
		public function Menu(flow:IUpdateDispatcher) 
		{
			this.initializeSize();
			this.initializeLayout();
			this.initializeButtons();
			
			this.flow = flow;
		}
		
		protected function initializeSize():void
		{
			this.width = Menu.WIDTH_MENU;
			this.height = Menu.HEIGHT_MENU;
		}
		
		protected function initializeLayout():void
		{
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = Menu.SPACE_BEETWEEN_BUTTON;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			
			this.layout = layout;
		}
		
		protected function initializeButtons():void 
		{
			this.playButton = ButtonMenuFactory.create("New game");
			this.addChild(this.playButton);
			
			this.statisticsButton = ButtonMenuFactory.create("Statistics");
			this.addChild(this.statisticsButton);
			
			this.achievementsButton = ButtonMenuFactory.create("Achievements");
			this.addChild(this.achievementsButton);
			
			this.creditsButton = ButtonMenuFactory.create("Credits");
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
				
				this.flow.dispatchUpdate(Update.toggleWindow, Windows.GAME);
				this.flow.dispatchUpdate(Update.newGame);
			}
			else if (event.target == this.statisticsButton)
			{
				this.flow.dispatchUpdate(Update.toggleWindow, Windows.STATISTICS);
			}
			else if (event.target == this.achievementsButton)
			{
				this.flow.dispatchUpdate(Update.toggleWindow, Windows.ACHIEVEMENTS);
			}
			else if (event.target == this.creditsButton)
			{
				this.flow.dispatchUpdate(Update.toggleWindow, Windows.CREDITS);
			}
		}
		
	}

}