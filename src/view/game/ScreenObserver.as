package view.game 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import starling.events.Event;
	import view.themes.GameTheme;
	
	internal class ScreenObserver extends Screen
	{
		private var controller:IGameController;
		
		
		public function ScreenObserver(binder:IBinder) 
		{
			this.controller = binder.gameController;
			
			
			
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
			this.controller.showGameMenu();
		}
	}
//TODO: rename class
//TODO: rename related View constant
}