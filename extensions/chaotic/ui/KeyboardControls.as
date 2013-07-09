package chaotic.ui 
{
	import chaotic.input.InputPiece;
	import chaotic.metric.DCellXY;
	import chaotic.updates.IUpdateDispatcher;
	import flash.ui.Keyboard;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;
	
	public class KeyboardControls
	{
		private var updateFlow:IUpdateDispatcher;
		
		public function KeyboardControls(flow:IUpdateDispatcher) 
		{
			this.updateFlow = flow;
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener("addKeyboardEventListenersTo");
		}
		
		public function addKeyboardEventListenersTo(item:EventDispatcher):void
		{
			item.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			item.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.updateFlow.dispatchUpdate("newInputPiece", new InputPiece(true, true, new DCellXY(0, -1)));
            else if (event.keyCode == Keyboard.DOWN)
		        this.updateFlow.dispatchUpdate("newInputPiece", new InputPiece(true, true, new DCellXY(0, 1)));
			else if (event.keyCode == Keyboard.RIGHT)
		        this.updateFlow.dispatchUpdate("newInputPiece", new InputPiece(true, true, new DCellXY(1, 0)));
			else if (event.keyCode == Keyboard.LEFT)
		        this.updateFlow.dispatchUpdate("newInputPiece", new InputPiece(true, true, new DCellXY(-1, 0)));
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.updateFlow.dispatchUpdate("newInputPiece", new InputPiece(true, false, new DCellXY(0, -1)));
            else if (event.keyCode == Keyboard.DOWN)
		        this.updateFlow.dispatchUpdate("newInputPiece", new InputPiece(true, false, new DCellXY(0, 1)));
			else if (event.keyCode == Keyboard.RIGHT)
		        this.updateFlow.dispatchUpdate("newInputPiece", new InputPiece(true, false, new DCellXY(1, 0)));
			else if (event.keyCode == Keyboard.LEFT)
		        this.updateFlow.dispatchUpdate("newInputPiece", new InputPiece(true, false, new DCellXY(-1, 0)));
		}
	}

}