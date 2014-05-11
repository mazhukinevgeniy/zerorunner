package view.shell 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	import view.shell.events.ShellEvent;
	import view.shell.factories.createButton;
	
	internal class MainScreen extends Screen
	{
		protected var playButton:Button,
					  achievementsButton:Button,
					  settingsButton:Button,
					  creditsButton:Button;
		
		private var gameController:IGameController;
		
		public function MainScreen(binder:IBinder) 
		{
			super();
			
			
			this.addChild(this.playButton = createButton("NEW GAME"));
			this.addChild(this.achievementsButton = createButton("TROPHIES"));
			this.addChild(this.settingsButton = createButton("OPTIONS"));
			this.addChild(this.creditsButton = createButton("CREDITS"));
			
			this.playButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.achievementsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.settingsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.creditsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			
			
			this.gameController = binder.gameController;
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