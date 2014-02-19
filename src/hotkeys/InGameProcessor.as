package hotkeys 
{
	import data.StatusReporter;
	import flash.ui.Keyboard;
	import game.GameElements;
	import game.metric.ProtectedDCellXY;
	import utils.updates.IUpdateDispatcher;
	
	internal class InGameProcessor extends ProcessorBase
	{
		private const UP:ProtectedDCellXY = new ProtectedDCellXY(0, -1);
		private const DOWN:ProtectedDCellXY = new ProtectedDCellXY(0, 1);
		private const RIGHT:ProtectedDCellXY = new ProtectedDCellXY(1, 0);
		private const LEFT:ProtectedDCellXY = new ProtectedDCellXY(-1, 0);
		
		private var flow:IUpdateDispatcher;
		private var status:StatusReporter;
		
		public function InGameProcessor(elements:GameElements) 
		{
			this.flow = elements.flow;
			this.status = elements.database.status;
		}
		
		override internal function processInput(keyUp:Boolean, keyCode:uint):void 
		{
			if (keyCode == Keyboard.UP)
				this.flow.dispatchUpdate(Update.newInputPiece, !keyUp, this.UP);
			else if (keyCode == Keyboard.DOWN)
				this.flow.dispatchUpdate(Update.newInputPiece, !keyUp, this.DOWN);
			else if (keyCode == Keyboard.RIGHT)
				this.flow.dispatchUpdate(Update.newInputPiece, !keyUp, this.RIGHT);
			else if (keyCode == Keyboard.LEFT)
				this.flow.dispatchUpdate(Update.newInputPiece, !keyUp, this.LEFT);
			else
			{
				if (status.isMapOn)
				{
					//TODO: add map-specific controls
				}
				else
				{
					if (!keyUp)
					{
						if (keyCode == Keyboard.SPACE)
							this.flow.dispatchUpdate(Update.spacePressed);
						else if (keyCode == Keyboard.P)
							this.flow.dispatchUpdate(Update.togglePause);
					}
				}
				
				if (!keyUp && keyCode == Keyboard.M)
					this.flow.dispatchUpdate(Update.toggleMap);
			}
		}
	}

}