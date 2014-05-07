package view.navigation 
{
	import feathers.controls.Button;
	import feathers.controls.ScrollContainer;
	import feathers.layout.VerticalLayout;
	import game.GameElements;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.utils.AssetManager;
	import ui.ButtonFactory;
	import ui.Windows;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Navigation extends ScrollContainer
	{
		public static const WIDTH:Number = 150;
		public static const HEIGHT:Number = 300;
		
		private static const SPACE_BEETWEEN_BUTTON:Number = 25;
		private static const START_HEIGHT_BUTTONS:Number = 50;
		
		private static const WIDTH_BUTTON:Number = 120;
		private static const HEIGHT_BUTTON:Number = 30;
		
		protected var flow:IUpdateDispatcher;
		
		protected var buttonFactory:ButtonFactory;
		
		protected var playButton:Button,
					achievementsButton:Button,
					settingsButton:Button,
					creditsButton:Button;
		
		private var resetButton:Button;
		
		public function Navigation(elements:GameElements) 
		{
			this.initializeSize();
			this.initializeLayout();
			
			this.flow = elements.flow;
			
			this.buttonFactory = new ButtonFactory(elements.assets, Navigation.WIDTH_BUTTON, Navigation.HEIGHT_BUTTON);
			this.initializeButtons();
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.newGame);
			this.flow.addUpdateListener(Update.quitGame);
		}
		
		protected function initializeSize():void
		{
			this.width = Navigation.WIDTH;
			this.height = Navigation.HEIGHT;
		}
		
		protected function initializeLayout():void
		{
			var layout:VerticalLayout = new VerticalLayout();
			layout.gap = Navigation.SPACE_BEETWEEN_BUTTON;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_MIDDLE;
			
			this.layout = layout;
		}
		
		protected function initializeButtons():void 
		{
			
			this.playButton = this.buttonFactory.createButton("New game");
			this.addChild(this.playButton);
			
			this.achievementsButton = this.buttonFactory.createButton("Achievements");
			this.addChild(this.achievementsButton);
			
			this.settingsButton = this.buttonFactory.createButton("Settings");
			this.addChild(this.settingsButton);
			
			this.creditsButton = this.buttonFactory.createButton("Credits");
			this.addChild(this.creditsButton);
			
			this.playButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.achievementsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.settingsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.creditsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
		}
		
		protected function handleMenuTriggered(event:Event):void
		{
			if (event.target == this.playButton)
			{
				this.flow.dispatchUpdate(Update.newGame);
			}
			else if (event.target == this.achievementsButton)
			{
				this.flow.dispatchUpdate(Update.toggleWindow, Windows.ACHIEVEMENTS);
			}
			else if (event.target == this.settingsButton)
			{
				this.flow.dispatchUpdate(Update.toggleWindow, Windows.SETTINGS);
			}
			else if (event.target == this.creditsButton)
			{
				this.flow.dispatchUpdate(Update.toggleWindow, Windows.CREDITS);
			}
		}
		
		update function newGame():void
		{
			this.visible = false;
			
			this.playButton.focusManager.focus = null;
			
			this.flow.dispatchUpdate(Update.toggleWindow, Windows.GAME);
		}
		
		update function quitGame():void
		{
			this.visible = true;
		}
		
	}

}