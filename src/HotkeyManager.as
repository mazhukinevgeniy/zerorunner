package  
{
	import data.DatabaseManager;
	import data.StatusReporter;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	
	internal class HotkeyManager 
	{
		//private var hotkeys:
		
		private var status:StatusReporter;
		
		public function HotkeyManager(data:DatabaseManager, root:IEventDispatcher) 
		{
			this.status = (data).status;
			
			root.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			/*
			if (keyCode == Keyboard.P && !this.status.isGameOn)
			{
				this.flow.dispatchUpdate(Update.newGame);//startGame
			}
			
			if (keyCode == Keyboard.P && this.status.isGameOn)
			{
				this.fixed = !this.fixed; //toggleGamePause
			}
			
			
			
			if (keyCode == Keyboard.M)
				this.update::toggleMute();//it's okay out of game
			*/
		}
	}

}