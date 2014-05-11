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
					  trophiesButton:Button,
					  optionsButton:Button,
					  creditsButton:Button;
		
		private var gameController:IGameController;
		
		public function MainScreen(binder:IBinder) 
		{
			super();
			
			
			this.addChild(this.playButton = createButton("NEW GAME"));
			this.addChild(this.trophiesButton = createButton("TROPHIES"));
			this.addChild(this.optionsButton = createButton("OPTIONS"));
			this.addChild(this.creditsButton = createButton("CREDITS"));
			
			this.playButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.trophiesButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.optionsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			this.creditsButton.addEventListener(Event.TRIGGERED, this.handleMenuTriggered);
			
			
			this.gameController = binder.gameController;
		}
		
		
		protected function handleMenuTriggered(event:Event):void
		{
			if (event.target == this.playButton)
			{
				this.gameController.newGame();
			}
			else if (event.target == this.trophiesButton)
			{
				this.dispatchEventWith(ShellEvent.SHOW_TROPHIES);
			}
			else if (event.target == this.optionsButton)
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