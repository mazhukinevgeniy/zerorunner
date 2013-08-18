package game.ui 
{
	import flash.ui.Keyboard;
	import game.core.input.InputManager;
	import game.core.input.InputPiece;
	import game.utils.metric.DCellXY;
	import starling.events.EventDispatcher;
	import starling.events.KeyboardEvent;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class KeyboardControls
	{
		public static const addKeyboardEventListenersTo:String = "addKeyboardEventListenersTo";
		
		private var updateFlow:IUpdateDispatcher;
		
		private const UP:DCellXY = new DCellXY(0, -1);
		private const DOWN:DCellXY = new DCellXY(0, 1);
		private const RIGHT:DCellXY = new DCellXY(1, 0);
		private const LEFT:DCellXY = new DCellXY(-1, 0);
		
		public function KeyboardControls(flow:IUpdateDispatcher) 
		{
			this.updateFlow = flow;
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(KeyboardControls.addKeyboardEventListenersTo);
		}
		
		update function addKeyboardEventListenersTo(item:EventDispatcher):void
		{
			item.addEventListener(KeyboardEvent.KEY_DOWN, this.handleKeyDown);
			item.addEventListener(KeyboardEvent.KEY_UP, this.handleKeyUp);
		}
		
		private function handleKeyDown(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, true, this.UP));
            else if (event.keyCode == Keyboard.DOWN)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, true, this.DOWN));
			else if (event.keyCode == Keyboard.RIGHT)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, true, this.RIGHT));
			else if (event.keyCode == Keyboard.LEFT)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, true, this.LEFT));
		}
		
		private function handleKeyUp(event:KeyboardEvent):void
		{
			if (event.keyCode == Keyboard.UP)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, false, this.UP));
            else if (event.keyCode == Keyboard.DOWN)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, false, this.DOWN));
			else if (event.keyCode == Keyboard.RIGHT)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, false, this.RIGHT));
			else if (event.keyCode == Keyboard.LEFT)
		        this.updateFlow.dispatchUpdate(InputManager.newInputPiece, new InputPiece(true, false, this.LEFT));
		}
	}

}