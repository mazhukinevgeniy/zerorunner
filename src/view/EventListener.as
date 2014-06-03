package view
{
	import binding.IBinder;
	import controller.interfaces.IInputController;
	import events.GlobalEvent;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import starling.events.EventDispatcher;
	
	public class EventListener
	{
		private var inputController:IInputController;
		private var dispatcher:EventDispatcher;
		
		private const UP:Boolean = true;
		
		public function EventListener(binder:IBinder, root:IEventDispatcher) 
		{
			this.inputController = binder.inputController;
			this.dispatcher = binder.eventDispatcher;
			
			root.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
			root.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			
			root.addEventListener(Event.ACTIVATE, this.handleActivation);
			root.addEventListener(Event.DEACTIVATE, this.handleDeactivation);
		}
		
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			this.inputController.processInput(this.UP, event.keyCode);
		}
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
			this.inputController.processInput(!this.UP, event.keyCode);
		}
		
		
		private function handleActivation(event:Event):void
		{
			this.dispatcher.dispatchEventWith(GlobalEvent.ACTIVATED);
		}
		
		private function handleDeactivation(event:Event):void
		{
			this.dispatcher.dispatchEventWith(GlobalEvent.DEACTIVATED);
		}
	}

}