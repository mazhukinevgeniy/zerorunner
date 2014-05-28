package model 
{
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import model.interfaces.IInput;
	import model.interfaces.IStatus;
	import starling.core.Starling;
	import starling.events.EnterFrameEvent;
	
	internal class Time implements INewGameHandler,
	                               IQuitGameHandler
	{
		private var frameCount:int = 0;
		
		private var isFixed:Boolean = true;
		
		private var status:IStatus;
		private var input:IInput;
		
		private var controller:IGameController;
		
		public function Time(binder:IBinder) 
		{
			binder.notifier.addObserver(this);
			
			this.status = binder.gameStatus;
			this.input = binder.input;
			
			Starling.current.root.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			this.controller = binder.gameController;
		}
		
		public function newGame():void
		{
			this.isFixed = false;
			
			this.frameCount = 0;
		}
		
		protected function handleEnterFrame(event:EnterFrameEvent):void 
		{
			if (!this.isFixed && !this.status.isMenuOn() &&
				((this.frameCount != Game.FRAME_TO_ACT) || 
				 !this.status.getSnapshotOfHero().isFree() || 
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
		
		public function quitGame():void 
		{ 
			this.isFixed = true;
			
			this.frameCount = 0;
		}
		
	}
	
}