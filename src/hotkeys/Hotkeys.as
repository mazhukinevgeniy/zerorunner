package hotkeys
{
	import data.DatabaseManager;
	import data.StatusReporter;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	
	public class Hotkeys
	{		
		private var status:StatusReporter;
		
		private var processors:Object;
		
		
		private const UP:Boolean = true;
		
		public function Hotkeys(data:DatabaseManager, root:IEventDispatcher) 
		{
			this.status = (data).status;
			
			root.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
			root.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			
			this.processors = new Object();
			const GAME_IS_ON:Boolean = true;
			
			this.processors[GAME_IS_ON] = new InGameProcessor();
			this.processors[!GAME_IS_ON] = new InShellProcessor();
		}
		
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			this.processors[this.status.isGameOn].processInput(this.UP, event.keyCode);
		}
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
			this.processors[this.status.isGameOn].processInput(!this.UP, event.keyCode);
		}
	}

}