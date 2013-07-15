package game.ui 
{
	import chaotic.core.IUpdateDispatcher;
	import game.input.InputManager;
	import game.input.InputPiece;
	import game.metric.DCellXY;
	import flash.ui.Keyboard;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;
	
	public class KeyboardControls
	{
		public static const addKeyboardEventListenersTo:String = "addKeyboardEventListenersTo";
		
		private var updateFlow:IUpdateDispatcher;
		
		public function KeyboardControls(flow:IUpdateDispatcher) 
		{
			this.updateFlow = flow;
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(KeyboardControls.addKeyboardEventListenersTo);
		}
		
		public function addKeyboardEventListenersTo(item:EventDispatcher):void
		{
			item.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			item.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)  //TODO: STOP ALLOCATING
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, true, new DCellXY(0, -1)));
            else if (event.keyCode == Keyboard.DOWN)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, true, new DCellXY(0, 1)));
			else if (event.keyCode == Keyboard.RIGHT)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, true, new DCellXY(1, 0)));
			else if (event.keyCode == Keyboard.LEFT)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, true, new DCellXY(-1, 0)));
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, false, new DCellXY(0, -1)));
            else if (event.keyCode == Keyboard.DOWN)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, false, new DCellXY(0, 1)));
			else if (event.keyCode == Keyboard.RIGHT)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, false, new DCellXY(1, 0)));
			else if (event.keyCode == Keyboard.LEFT)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, false, new DCellXY(-1, 0)));
		}
	}

}