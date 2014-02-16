package hotkeys
{
	import data.DatabaseManager;
	import data.StatusReporter;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	
	public class Hotkeys
	{
		private static var created:Boolean = false;
		//private var hotkeys:
		
		private var status:StatusReporter;
		
		private var ingame:InGameProcessor;
		private var inshell:InShellProcessor;
		
		public function Hotkeys(data:DatabaseManager, root:IEventDispatcher) 
		{
			if (Hotkeys.created)
				throw new Error();
			else
				Hotkeys.created = true;
			
			
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