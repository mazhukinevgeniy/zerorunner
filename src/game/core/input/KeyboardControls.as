package game.core.input 
{
	import flash.ui.Keyboard;
	import game.core.metric.DCellXY;
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;
	
	internal class KeyboardControls
	{
		private const UP:DCellXY = new DCellXY(0, -1);
		private const DOWN:DCellXY = new DCellXY(0, 1);
		private const RIGHT:DCellXY = new DCellXY(1, 0);
		private const LEFT:DCellXY = new DCellXY(-1, 0);
		
		private var input:InputManager;
		
		public function KeyboardControls(collector:InputManager) 
		{
			this.input = collector;
			
			var events:EventDispatcher = Starling.current.stage;
			events.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			events.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.input.newInputPiece(true, true, this.UP);
            else if (event.keyCode == Keyboard.DOWN)
		        this.input.newInputPiece(true, true, this.DOWN);
			else if (event.keyCode == Keyboard.RIGHT)
		        this.input.newInputPiece(true, true, this.RIGHT);
			else if (event.keyCode == Keyboard.LEFT)
		        this.input.newInputPiece(true, true, this.LEFT);
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.input.newInputPiece(true, false, this.UP);
            else if (event.keyCode == Keyboard.DOWN)
		        this.input.newInputPiece(true, false, this.DOWN);
			else if (event.keyCode == Keyboard.RIGHT)
		        this.input.newInputPiece(true, false, this.RIGHT);
			else if (event.keyCode == Keyboard.LEFT)
		        this.input.newInputPiece(true, false, this.LEFT);
			
			else if (event.keyCode == Keyboard.SPACE)
				this.input.spacePressed();
		}
	}

}