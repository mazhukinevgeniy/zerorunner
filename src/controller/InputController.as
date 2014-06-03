package controller 
{
	import binding.IBinder;
	import binding.IDependent;
	import controller.interfaces.IInputController;
	import events.GlobalEvent;
	import flash.ui.Keyboard;
	import model.interfaces.ISave;
	import model.interfaces.IStatus;
	import model.metric.ProtectedDCellXY;
	import starling.events.EventDispatcher;
	import structs.InputPiece;
	import structs.SoundMute;
	
	internal class InputController implements IInputController,
								              IDependent
	{
		private const UP:ProtectedDCellXY = new ProtectedDCellXY(0, -1);
		private const DOWN:ProtectedDCellXY = new ProtectedDCellXY(0, 1);
		private const RIGHT:ProtectedDCellXY = new ProtectedDCellXY(1, 0);
		private const LEFT:ProtectedDCellXY = new ProtectedDCellXY(-1, 0);
		
		private var status:IStatus;
		private var save:ISave;
		
		private var dispatcher:EventDispatcher;
		
		public function InputController(binder:IBinder) 
		{
			binder.requestBindingFor(this);
			
			this.dispatcher = binder.eventDispatcher;
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
				this.dispatcher.dispatchEventWith(GlobalEvent.ADD_INPUT_PIECE,
				                                  false,
												  new InputPiece(!keyUp, this.UP));
			else if (keyCode == Keyboard.DOWN)
				this.dispatcher.dispatchEventWith(GlobalEvent.ADD_INPUT_PIECE,
				                                  false,
												  new InputPiece(!keyUp, this.DOWN));
			else if (keyCode == Keyboard.RIGHT)
				this.dispatcher.dispatchEventWith(GlobalEvent.ADD_INPUT_PIECE,
				                                  false,
												  new InputPiece(!keyUp, this.RIGHT));
			else if (keyCode == Keyboard.LEFT)
				this.dispatcher.dispatchEventWith(GlobalEvent.ADD_INPUT_PIECE,
				                                  false,
												  new InputPiece(!keyUp, this.LEFT));
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
							this.dispatcher.dispatchEventWith(GlobalEvent.PERFORM_ACTION,
							                                  false,
															  Game.ACTION_SKIP_FRAME);
					}
					else
					{
						if (keyCode == Keyboard.ESCAPE)
						{
							if (this.status.isMenuOn())
								this.dispatcher.dispatchEventWith(GlobalEvent.ACTIVATE_GAME_SCREEN,
								                                  false,
								                                  View.GAME_SCREEN);
							else
								this.dispatcher.dispatchEventWith(GlobalEvent.ACTIVATE_GAME_SCREEN,
								                                  false,
								                                  View.GAME_SCREEN_MENU);
						}
					}
				}
				
				if (!keyUp && keyCode == Keyboard.M)
				{
					if (this.status.isMapOn())
						this.dispatcher.dispatchEventWith(GlobalEvent.ACTIVATE_GAME_SCREEN,
						                                  false,
								                          View.GAME_SCREEN);
					else
						this.dispatcher.dispatchEventWith(GlobalEvent.ACTIVATE_GAME_SCREEN,
						                                  false,
								                          View.GAME_SCREEN_MAP);
				}
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
						this.dispatcher.dispatchEventWith(GlobalEvent.SET_SOUND_MUTE,
						                                  false,
														  new SoundMute(i, mute));
				}
			}
		}
	}

}