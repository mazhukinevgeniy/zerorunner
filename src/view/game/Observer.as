package view.game 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import feathers.controls.ScreenNavigator;
	import starling.events.Event;
	import starling.events.EventDispatcher;
	
	internal class Observer
	{
		private var navigator:ScreenNavigator;
		
		private var dispatcher:EventDispatcher;
		
		public function Observer(binder:IBinder, navigator:ScreenNavigator) 
		{
			this.navigator = navigator;
			
			binder.eventDispatcher.addEventListener(GlobalEvent.NEW_GAME,
			                                        this.newGame);
			binder.eventDispatcher.addEventListener(GlobalEvent.ACTIVATE_GAME_SCREEN,
			                                        this.activateScreen);
			binder.eventDispatcher.addEventListener(GlobalEvent.GAME_STOPPED,
			                                        this.gameStopped);
			
			this.dispatcher = binder.eventDispatcher;
		}
		
		
		private function gameStopped(event:Event, reason:int):void
		{
			if (reason != Game.ENDING_ABANDONED)
			{
				if (reason == Game.ENDING_WON)
				{
					this.navigator.showScreen(View.GAME_SCREEN_WON);
				}
				else if (reason == Game.ENDING_LOST)
				{
					this.navigator.showScreen(View.GAME_SCREEN_LOST);
				}
			}
		}
		
		private function activateScreen(event:Event, screen:String):void
		{
			this.navigator.showScreen(screen);
			//TODO: fix the weirdness, ENDING screens are never called this way
		}
		
		private function newGame():void
		{
			this.dispatcher.dispatchEventWith(GlobalEvent.ACTIVATE_GAME_SCREEN,
			                                  false,
											  View.GAME_SCREEN);
			//TODO: fix the weirdness, why isn't it the other way around?
		}
	}

}