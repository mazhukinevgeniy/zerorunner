package view.game 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.layout.VerticalLayout;
	import model.interfaces.IStatus;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	import view.themes.GameTheme;
	import view.utils.createButton;
	
	internal class GameMenuScreen extends Screen
	{
		private var status:IStatus;
		
		private var dispatcher:EventDispatcher;
		
		public function GameMenuScreen(binder:IBinder) 
		{
			super();
			
			this.setLayout();
			this.status = binder.gameStatus;
			
			this.dispatcher = binder.eventDispatcher;
			
			
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
				this.dispatcher.dispatchEventWith(GlobalEvent.GAME_STOPPED,
				                                  false,
												  Game.ENDING_ABANDONED);
			
			this.dispatcher.dispatchEventWith(GlobalEvent.QUIT_GAME);
		}
		
		private function handleMapTriggered():void
		{
			this.dispatcher.dispatchEventWith(GlobalEvent.ACTIVATE_GAME_SCREEN,
			                                  false,
											  View.GAME_SCREEN_MAP);
		}
	}

}