package listeners
{
	import data.StatusReporter;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import game.GameElements;
	import utils.updates.IUpdateDispatcher;
	
	public class EventListener
	{		
		private var status:StatusReporter;
		
		
		private var flow:IUpdateDispatcher;
		private var processors:Object;
		
		
		private const UP:Boolean = true;
		
		public function EventListener(elements:GameElements, root:IEventDispatcher) 
		{
			this.status = elements.status;
			this.flow = elements.flow;
			
			root.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
			root.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			
			this.processors = new Object();
			const GAME_IS_ON:Boolean = true;
			
			this.processors[GAME_IS_ON] = new InGameProcessor(elements);
			this.processors[!GAME_IS_ON] = new InShellProcessor(elements);
			
			root.addEventListener(Event.DEACTIVATE, this.handleDeactivation);
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			this.processors[this.status.isGameOn()].processInput(this.UP, event.keyCode);
		}
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
			this.processors[this.status.isGameOn()].processInput(!this.UP, event.keyCode);
		}
		
		private function handleDeactivation(event:Event):void
		{
			this.flow.dispatchUpdate(Update.handleDeactivation);
		}
	}

}