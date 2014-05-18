package view.game 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.layout.VerticalLayout;
	import model.interfaces.IStatus;
	import starling.events.Event;
	import view.themes.GameTheme;
	import view.utils.createButton;
	
	internal class GameMenuScreen extends Screen
	{
		private var controller:IGameController;
		private var status:IStatus;
		
		public function GameMenuScreen(binder:IBinder) 
		{
			super();
			
			this.setLayout();
			this.status = binder.gameStatus;
			this.controller = binder.gameController;
			
			
			var button:Button;
			
			this.addChild(button = createButton("menu", GameTheme.MENU_BUTTON));
			button.addEventListener(Event.TRIGGERED, this.handleQuitTriggered);
			
			this.addChild(button = createButton("map", GameTheme.MENU_BUTTON));
			button.addEventListener(Event.TRIGGERED, this.handleMapTriggered);
		}
		
		private function setLayout():void
		{
			var layout:VerticalLayout = new VerticalLayout();
			
			layout.gap = 10;
			
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_LEFT;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			
			this.layout = layout;
		}
		
		
		
		private function handleQuitTriggered():void
		{
			if (this.status.isGameOn())
				this.controller.gameStopped(Game.ENDING_ABANDONED);
			
			this.controller.quitGame();
		}
		
		private function handleMapTriggered():void
		{
			this.controller.showGameMap();
		}
	}

}