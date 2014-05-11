package view.shell 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	import view.shell.events.ShellEvent;
	import view.shell.factories.createButton;
	
	internal class MainMenuScreen extends Screen
	{
		private var gameController:IGameController;
		
		public function MainMenuScreen(binder:IBinder) 
		{
			super();
			
			
			var button:Button;
			
			this.addChild(button = createButton("NEW GAME"));
			button.addEventListener(Event.TRIGGERED, this.handleNewGameTriggered);
			
			this.addChild(button = createButton("TROPHIES"));
			button.addEventListener(Event.TRIGGERED, this.handleTrophiesTriggered);
			
			this.addChild(button = createButton("OPTIONS"));
			button.addEventListener(Event.TRIGGERED, this.handleOptionsTriggered);
			
			this.addChild(button = createButton("CREDITS"));
			button.addEventListener(Event.TRIGGERED, this.handleCreditsTriggered);
			
			
			
			this.gameController = binder.gameController;
		}
		
		private function handleNewGameTriggered():void
		{
			this.gameController.newGame();
		}
		
		private function handleTrophiesTriggered():void
		{
			this.dispatchEventWith(ShellEvent.SHOW_TROPHIES);
		}
		
		private function handleOptionsTriggered():void
		{
			this.dispatchEventWith(ShellEvent.SHOW_OPTIONS);
		}
		
		private function handleCreditsTriggered():void
		{
			this.dispatchEventWith(ShellEvent.SHOW_CREDITS);
		}
		
	}

}