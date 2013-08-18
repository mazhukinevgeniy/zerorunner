package game.utils.input 
{
	import flash.ui.Keyboard;
	import game.utils.metric.DCellXY;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class KeyboardControls
	{
		private const UP:DCellXY = new DCellXY(0, -1);
		private const DOWN:DCellXY = new DCellXY(0, 1);
		private const RIGHT:DCellXY = new DCellXY(1, 0);
		private const LEFT:DCellXY = new DCellXY(-1, 0);
		
		private var input:InputManager;
		
		public function KeyboardControls(flow:IUpdateDispatcher, collector:InputManager) 
		{
			this.input = collector;
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(Update.addKeyboardEventListenersTo);
		}
		
		update function addKeyboardEventListenersTo(item:EventDispatcher):void
		{
			item.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			item.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.input.newInputPiece(new InputPiece(true, true, this.UP));
            else if (event.keyCode == Keyboard.DOWN)
		        this.input.newInputPiece(new InputPiece(true, true, this.DOWN));
			else if (event.keyCode == Keyboard.RIGHT)
		        this.input.newInputPiece(new InputPiece(true, true, this.RIGHT));
			else if (event.keyCode == Keyboard.LEFT)
		        this.input.newInputPiece(new InputPiece(true, true, this.LEFT));
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.input.newInputPiece(new InputPiece(true, false, this.UP));
            else if (event.keyCode == Keyboard.DOWN)
		        this.input.newInputPiece(new InputPiece(true, false, this.DOWN));
			else if (event.keyCode == Keyboard.RIGHT)
		        this.input.newInputPiece(new InputPiece(true, false, this.RIGHT));
			else if (event.keyCode == Keyboard.LEFT)
		        this.input.newInputPiece(new InputPiece(true, false, this.LEFT));
		}
	}//TODO: new new new, remove it

}