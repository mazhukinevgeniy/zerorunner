package view.shell 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import view.shell.events.ShellEvent;
	import view.themes.ShellTheme;
	import view.utils.createButton;
	
	internal class MainMenuScreen extends Screen
	{
		private var globalDispatcher:EventDispatcher;
		
		public function MainMenuScreen(binder:IBinder) 
		{
			super();
			
			this.globalDispatcher = binder.eventDispatcher;
			
			
			var button:Button;
			
			this.addChild(button = createButton("NEW GAME", ShellTheme.NAVIGATION_BUTTON));
			button.addEventListener(Event.TRIGGERED, this.handleNewGameTriggered);
			
			this.addChild(button = createButton("MEMORIES", ShellTheme.NAVIGATION_BUTTON));
			button.addEventListener(Event.TRIGGERED, this.handleMemoriesTriggered);
			
			this.addChild(button = createButton("OPTIONS", ShellTheme.NAVIGATION_BUTTON));
			button.addEventListener(Event.TRIGGERED, this.handleOptionsTriggered);
			
			this.addChild(button = createButton("CREDITS", ShellTheme.NAVIGATION_BUTTON));
			button.addEventListener(Event.TRIGGERED, this.handleCreditsTriggered);
		}
		
		private function handleNewGameTriggered():void
		{
			this.globalDispatcher.dispatchEventWith(GlobalEvent.NEW_GAME);
		}
		
		private function handleMemoriesTriggered():void
		{
			this.dispatchEventWith(ShellEvent.SHOW_MEMORIES);
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