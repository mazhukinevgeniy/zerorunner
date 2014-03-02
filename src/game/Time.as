package game 
{
	import data.StatusReporter;
	import data.viewers.GameConfig;
	import game.GameElements;
	import starling.events.EnterFrameEvent;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Time
	{
		private var frameCount:int = 0;
		
		private var isFixed:Boolean = true;
		
		private var updateFlow:IUpdateDispatcher;
		private var status:StatusReporter;
		
		public function Time(elements:GameElements) 
		{
			this.status = elements.database.status;
			
			elements.displayRoot.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.restore);
			elements.flow.addUpdateListener(Update.togglePause);
			elements.flow.addUpdateListener(Update.gameFinished);
			
			this.updateFlow = elements.flow;
		}
		
		update function restore(config:GameConfig):void
		{
			this.isFixed = false;
			
			this.frameCount = 0;
		}
		
		protected function handleEnterFrame(event:EnterFrameEvent):void 
		{
			if (this.status.isMapOn)
			{
				this.updateFlow.dispatchUpdate(Update.frameOfTheMapMode);
			}
			else if (!this.isFixed)
			{
				if (!this.status.isGameOn)
					throw new Error("numberedFrame must happen in-game only");
				
				if (this.frameCount < Game.FRAMES_PER_CYCLE)
				{
					this.updateFlow.dispatchUpdate(Update.numberedFrame, this.frameCount);
					this.frameCount++;
				}
				else
				{
					this.frameCount = 0;
				}
			}
		}
		
		
		update function togglePause():void
		{
			this.isFixed = !this.isFixed;
			
			this.updateFlow.dispatchUpdate(Update.timeFixed, this.isFixed);
		}
		
		update function gameFinished(key:int):void 
		{ 
			this.isFixed = true;
			
			this.frameCount = 0;
		}
		
	}
	
}