package game.core.input 
{
	import flash.ui.Keyboard;
	import game.core.metric.DCellXY;
	import game.core.metric.ProtectedDCellXY;
	import starling.core.Starling;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;
	
	internal class KeyboardControls
	{
		private const UP:DCellXY = new ProtectedDCellXY(0, -1);
		private const DOWN:DCellXY = new ProtectedDCellXY(0, 1);
		private const RIGHT:DCellXY = new ProtectedDCellXY(1, 0);
		private const LEFT:DCellXY = new ProtectedDCellXY(-1, 0);
		
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
			const KEY:Boolean = true;
			const PRESSED:Boolean = true;
			
			if (event.keyCode == Keyboard.UP)
		        this.input.newInputPiece(KEY, PRESSED, this.UP);
            else if (event.keyCode == Keyboard.DOWN)
		        this.input.newInputPiece(KEY, PRESSED, this.DOWN);
			else if (event.keyCode == Keyboard.RIGHT)
		        this.input.newInputPiece(KEY, PRESSED, this.RIGHT);
			else if (event.keyCode == Keyboard.LEFT)
		        this.input.newInputPiece(KEY, PRESSED, this.LEFT);
			
			else if (event.keyCode == Keyboard.SPACE)
				this.input.spacePressed();
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			const KEY:Boolean = true;
			const PRESSED:Boolean = false;
			
			if (event.keyCode == Keyboard.UP)
		        this.input.newInputPiece(KEY, PRESSED, this.UP);
            else if (event.keyCode == Keyboard.DOWN)
		        this.input.newInputPiece(KEY, PRESSED, this.DOWN);
			else if (event.keyCode == Keyboard.RIGHT)
		        this.input.newInputPiece(KEY, PRESSED, this.RIGHT);
			else if (event.keyCode == Keyboard.LEFT)
		        this.input.newInputPiece(KEY, PRESSED, this.LEFT);
		}
	}

}