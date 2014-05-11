package view.shell 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	import view.shell.events.ShellEvent;
	
	internal class MainScreen extends Screen
	{
		protected var buttonFactory:ButtonFactory;
		
		protected var playButton:Button,
					  achievementsButton:Button,
					  settingsButton:Button,
					  creditsButton:Button;
		
		private var gameController:IGameController;
		
		public function MainScreen(binder:IBinder) 
		{
			super();
			
			
			this.buttonFactory = new ButtonFactory(binder.assetManager);
			this.initializeButtons(); //TODO: something is weird here
			
			this.gameController = binder.gameController;
			
			
		}
		
		
		
		
		protected function initializeButtons():void 
		{
			//TODO: you tell me why do we use buttonfactory anyway
			this.playButton = this.buttonFactory.createButton("NEW GAME");
			this.addChild(this.playButton);
			
			this.achievementsButton = this.buttonFactory.createButton("TROPHIES");
			this.addChild(this.achievementsButton);
			
			this.settingsButton = this.buttonFactory.createButton("OPTIONS");
			this.addChild(this.settingsButton);
			
			this.creditsButton = this.buttonFactory.createButton("CREDITS");
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
				this.gameController.newGame();
			}
			else if (event.target == this.achievementsButton)//TODO: rename button
			{
				this.dispatchEventWith(ShellEvent.SHOW_TROPHIES);
			}
			else if (event.target == this.settingsButton)
			{
				this.dispatchEventWith(ShellEvent.SHOW_OPTIONS);
			}
			else if (event.target == this.creditsButton)
			{
				this.dispatchEventWith(ShellEvent.SHOW_CREDITS);
			}
		}
		
	}

}