package hotkeys
{
	import data.StatusReporter;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import game.GameElements;
	
	public class Hotkeys
	{		
		private var status:StatusReporter;
		
		private var processors:Object;
		
		
		private const UP:Boolean = true;
		
		public function Hotkeys(elements:GameElements, root:IEventDispatcher) 
		{
			this.status = elements.database.status;
			
			root.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
			root.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			
			this.processors = new Object();
			const GAME_IS_ON:Boolean = true;
			
			this.processors[GAME_IS_ON] = new InGameProcessor(elements);
			this.processors[!GAME_IS_ON] = new InShellProcessor(elements);
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