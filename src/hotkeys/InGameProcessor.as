package hotkeys 
{
	import game.core.metric.ProtectedDCellXY;
	
	internal class InGameProcessor extends ProcessorBase
	{
		private const UP:ProtectedDCellXY = new ProtectedDCellXY(0, -1);
		private const DOWN:ProtectedDCellXY = new ProtectedDCellXY(0, 1);
		private const RIGHT:ProtectedDCellXY = new ProtectedDCellXY(1, 0);
		private const LEFT:ProtectedDCellXY = new ProtectedDCellXY(-1, 0);
		
		public function InGameProcessor() 
		{
			
		}
		
		override internal function processInput(keyUp:Boolean, keyCode:uint):void 
		{
			/*if (keyCode == Keyboard.P && this.status.isGameOn)
			{
				this.fixed = !this.fixed; //toggleGamePause
			}*/
		}
		
		/*private function handleKeyDown(event:KeyboardEvent):void
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
		}*/
	}

}