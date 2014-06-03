package view.game 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import view.themes.GameTheme;
	
	internal class GameScreen extends Screen
	{
		private var dispatcher:EventDispatcher;
		
		
		public function GameScreen(binder:IBinder) 
		{
			this.dispatcher = binder.eventDispatcher;
			
			
			
			this.initializeToggle();
		}
		
		
		private function initializeToggle():void
		{
			var menuButton:Button = new Button();
			menuButton.name = GameTheme.MENU_TOGGLE;
			
			this.addChild(menuButton);
			
			menuButton.x = 10;
			menuButton.y = 10;
			
			menuButton.addEventListener(Event.TRIGGERED, this.handleMenuButtonTriggered);
		}
		
		private function handleMenuButtonTriggered():void
		{
			this.dispatcher.dispatchEventWith(GlobalEvent.ACTIVATE_GAME_SCREEN,
			                                  false,
											  View.GAME_SCREEN_MENU);
		}
	}
	
}