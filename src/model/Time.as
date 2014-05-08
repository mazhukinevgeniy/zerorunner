package model 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import controller.observers.game.IGameMenuRelated;
	import controller.observers.game.IGameStopHandler;
	import controller.observers.game.INewGameHandler;
	import model.interfaces.IInput;
	import model.interfaces.IStatus;
	import starling.core.Starling;
	import starling.events.EnterFrameEvent;
	
	internal class Time implements INewGameHandler,
	                               IGameStopHandler,
	                               IGameMenuRelated
	{
		private var frameCount:int = 0;
		
		private var isFixed:Boolean = true;
		private var isMenuOpened:Boolean = false;
		
		private var status:IStatus;
		private var input:IInput;
		
		private var controller:IGameController;
		
		public function Time(binder:IBinder) 
		{
			binder.notifier.addGameStatusObserver(this);
			
			this.status = binder.gameStatus;
			this.input = binder.input;
			
			Starling.current.root.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			this.controller = binder.gameController;
		}
		
		public function newGame():void
		{
			this.isFixed = false;
			this.isMenuOpened = false;
			
			this.frameCount = 0;
		}
		
		public function setVisibilityOfMenu(visible:Boolean):void
		{
			this.isMenuOpened = visible;
		}
		
		protected function handleEnterFrame(event:EnterFrameEvent):void 
		{
			if (!this.isFixed && !this.isMenuOpened &&
				((this.frameCount != Game.FRAME_TO_ACT) || 
				 !this.status.isHeroFree() || 
				 this.input.isThereInput()))
			{
				if (this.status.isMapOn())
				{
					this.controller.mapFrame();
				}
				else
				{
					if (!this.status.isGameOn())
						throw new Error("numberedFrame must happen in-game only");
					
					this.controller.gameFrame(this.frameCount);
					this.frameCount++;
					
					if (this.frameCount >= Game.FRAMES_PER_CYCLE)
						this.frameCount = 0;
				}
			}
		}
		
		public function gameStopped(reason:int):void 
		{ 
			this.isFixed = true;
			
			this.frameCount = 0;
		}
		
	}
	
}