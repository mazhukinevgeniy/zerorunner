package controller 
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.interfaces.IInputController;
	import flash.ui.Keyboard;
	import model.interfaces.ISave;
	import model.interfaces.IStatus;
	import model.metric.ProtectedDCellXY;
	
	internal class InputController implements IInputController,
								   IDependent
	{
		private const UP:ProtectedDCellXY = new ProtectedDCellXY(0, -1);
		private const DOWN:ProtectedDCellXY = new ProtectedDCellXY(0, 1);
		private const RIGHT:ProtectedDCellXY = new ProtectedDCellXY(1, 0);
		private const LEFT:ProtectedDCellXY = new ProtectedDCellXY(-1, 0);
		
		private var status:IStatus;
		private var save:ISave;
		
		private var notifier:Notifier;
		
		public function InputController(notifier:Notifier, binder:IBinder) 
		{
			binder.requestBindingFor(this);
			
			this.notifier = notifier;
		}
		
		public function bindObjects(binder:IBinder):void
		{
			this.status = binder.gameStatus;
			this.save = binder.save;
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
				this.notifier.newInputPiece(!keyUp, this.UP);
			else if (keyCode == Keyboard.DOWN)
				this.notifier.newInputPiece(!keyUp, this.DOWN);
			else if (keyCode == Keyboard.RIGHT)
				this.notifier.newInputPiece(!keyUp, this.RIGHT);
			else if (keyCode == Keyboard.LEFT)
				this.notifier.newInputPiece(!keyUp, this.LEFT);
			else
			{
				if (this.status.isMapOn())
				{
					/* map-specific controls */
				}
				else
				{
					if (!keyUp)
					{
						if (keyCode == Keyboard.Q)
							this.notifier.actionRequested(Game.ACTION_SKIP_FRAME);
					}
					else
					{
						if (keyCode == Keyboard.ESCAPE)
							this.notifier.setVisibilityOfMenu(!this.status.isMenuOn());
					}
				}
				
				if (!keyUp && keyCode == Keyboard.M)
					this.notifier.setVisibilityOfMap(!this.status.isMapOn());
			}
		}
		
		
		private function processInShellInput(keyUp:Boolean, keyCode:uint):void
		{
			if (keyUp)
			{
				if (keyCode == Keyboard.M)
				{
					var mute:Boolean = !this.save.getSoundMute(View.SOUND_MUSIC) || 
					                   !this.save.getSoundMute(View.SOUND_EFFECT);
					
					for (var i:int = 0; i < View.NUMBER_OF_SOUND_TYPES; i++)
						this.notifier.setSoundMute(i, mute);
				}
			}
		}
		
		
		public function processActivation():void
		{
			this.notifier.processActivation();
		}
		
		public function processDeactivation():void
		{
			this.notifier.processDeactivation();
		}
	}

}