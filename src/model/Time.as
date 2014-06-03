package model 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import model.interfaces.IInput;
	import model.interfaces.IStatus;
	import starling.core.Starling;
	import starling.events.EnterFrameEvent;
	import starling.events.EventDispatcher;
	
	internal class Time
	{
		private var isFixed:Boolean = true;
		
		private var status:IStatus;
		private var input:IInput;
		
		private var dispatcher:EventDispatcher;
		
		public function Time(binder:IBinder) 
		{
			this.status = binder.gameStatus;
			this.input = binder.input;
			
			Starling.current.root.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			this.dispatcher = binder.eventDispatcher;
			
			binder.eventDispatcher.addEventListener(GlobalEvent.NEW_GAME,
			                                        this.newGame);
			binder.eventDispatcher.addEventListener(GlobalEvent.QUIT_GAME,
			                                        this.quitGame);
		}
		
		private function newGame():void
		{
			this.isFixed = false;
		}
		
		private function quitGame():void 
		{ 
			this.isFixed = true;
		}
		
		protected function handleEnterFrame(event:EnterFrameEvent):void 
		{
			if (!this.isFixed && !this.status.isMenuOn() &&
				(!this.status.getSnapshotOfHero().isFree() || 
				 this.input.isThereInput()))
			{
				if (this.status.isMapOn())
				{
					this.dispatcher.dispatchEventWith(GlobalEvent.MAP_FRAME);
				}
				else if (this.status.isGameOn())
				{
					this.dispatcher.dispatchEventWith(GlobalEvent.GAME_FRAME);
				}
			}
		}
		
	}
	
}