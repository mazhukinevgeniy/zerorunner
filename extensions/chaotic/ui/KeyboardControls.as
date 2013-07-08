package chaotic.ui 
{
	import chaotic.core.ChaoticFeature;
	import chaotic.input.InputPiece;
	import chaotic.metric.DCellXY;
	import chaotic.updates.IEventAdder;
	import chaotic.updates.Update;
	import flash.ui.Keyboard;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;
	
	public class KeyboardControls extends ChaoticFeature implements IEventAdder
	{
		
		public function KeyboardControls() 
		{
			
		}
		
		public function addKeyboardEventListenersTo(item:EventDispatcher):void
		{
			item.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			item.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.dispatchUpdate(new Update("newInputPiece", new InputPiece(true, true, new DCellXY(0, -1))));
            else if (event.keyCode == Keyboard.DOWN)
		        this.dispatchUpdate(new Update("newInputPiece", new InputPiece(true, true, new DCellXY(0, 1))));
			else if (event.keyCode == Keyboard.RIGHT)
		        this.dispatchUpdate(new Update("newInputPiece", new InputPiece(true, true, new DCellXY(1, 0))));
			else if (event.keyCode == Keyboard.LEFT)
		        this.dispatchUpdate(new Update("newInputPiece", new InputPiece(true, true, new DCellXY(-1, 0))));
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.dispatchUpdate(new Update("newInputPiece", new InputPiece(true, false, new DCellXY(0, -1))));
            else if (event.keyCode == Keyboard.DOWN)
		        this.dispatchUpdate(new Update("newInputPiece", new InputPiece(true, false, new DCellXY(0, 1))));
			else if (event.keyCode == Keyboard.RIGHT)
		        this.dispatchUpdate(new Update("newInputPiece", new InputPiece(true, false, new DCellXY(1, 0))));
			else if (event.keyCode == Keyboard.LEFT)
		        this.dispatchUpdate(new Update("newInputPiece", new InputPiece(true, false, new DCellXY(-1, 0))));
		}
	}

}