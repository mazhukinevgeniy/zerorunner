package controller 
{
	import controller.interfaces.IInputController;
	import flash.ui.Keyboard;
	
	internal class Keys implements IInputController
	{
		private const UP:ProtectedDCellXY = new ProtectedDCellXY(0, -1);
		private const DOWN:ProtectedDCellXY = new ProtectedDCellXY(0, 1);
		private const RIGHT:ProtectedDCellXY = new ProtectedDCellXY(1, 0);
		private const LEFT:ProtectedDCellXY = new ProtectedDCellXY(-1, 0);
		
		private var flow:IUpdateDispatcher;
		private var status:IStatus;
		
		private var gameMenu:IGameMenu;
		private var input:InputCollector;
		
		
		public function Keys(elements:GameElements) 
		{
			this.flow = elements.flow;
			this.status = elements.status;
			
			this.gameMenu = elements.gameMenu;
			this.input = elements.inputCollector;
		}
		
		public function processInput(keyUp:Boolean, keyCode:uint):void
		{
			if (this.status.isGameOn())
				this.processInGameInput(keyUp, keyCode);
			else
				this.processInShellInput(keyUp, keyCode);
		}
		
		
		private function processInGameInput(keyUp:Boolean, keyCode:uint):void 
		{
			if (keyCode == Keyboard.UP)
				this.input.newInputPiece(!keyUp, this.UP);
			else if (keyCode == Keyboard.DOWN)
				this.input.newInputPiece(!keyUp, this.DOWN);
			else if (keyCode == Keyboard.RIGHT)
				this.input.newInputPiece(!keyUp, this.RIGHT);
			else if (keyCode == Keyboard.LEFT)
				this.input.newInputPiece(!keyUp, this.LEFT);
			else
			{
				if (status.isMapOn())
				{
					/* map-specific controls */
				}
				else
				{
					if (!keyUp)
					{
						if (keyCode == Keyboard.Q)
							this.input.actionRequested(Game.ACTION_SKIP_FRAME);
					}
					else
					{
						if (keyCode == Keyboard.W)
							this.input.actionRequested(Game.ACTION_FLIGHT);
						else if (keyCode == Keyboard.ESCAPE)
							this.gameMenu.toggleVisibility();
					}
				}
				
				if (!keyUp && keyCode == Keyboard.M)
					this.flow.dispatchUpdate(Update.toggleMap);
			}
		}
		
		
		private function processInShellInput(keyUp:Boolean, keyCode:uint):void
		{
			if (keyUp)
			{
				if (keyCode == Keyboard.P)
				{
					this.flow.dispatchUpdate(Update.newGame);
				}
				else if (keyCode == Keyboard.M)
				{
					this.flow.dispatchUpdate(Update.toggleMute);
				}
			}
		}
	}

}