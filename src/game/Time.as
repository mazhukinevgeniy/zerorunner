package game 
{
	import data.StatusReporter;
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.input.IKnowInput;
	import starling.events.EnterFrameEvent;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Time
	{
		private var frameCount:int = 0;
		
		private var isFixed:Boolean = true;
		
		private var isMenuOpened:Boolean = false;
		
		private var updateFlow:IUpdateDispatcher;
		private var status:StatusReporter;
		
		private var input:IKnowInput;
		
		public function Time(elements:GameElements) 
		{
			this.status = elements.database.status;
			this.input = elements.input;
			
			elements.displayRoot.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.restore);
			elements.flow.addUpdateListener(Update.gameFinished);
			elements.flow.addUpdateListener(Update.setVisibilityOfGameMenu);
			
			this.updateFlow = elements.flow;
		}
		
		update function restore(config:GameConfig):void
		{
			this.isFixed = false;
			this.isMenuOpened = false;
			
			this.frameCount = 0;
		}
		
		update function setVisibilityOfGameMenu(visible:Boolean):void
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
					this.updateFlow.dispatchUpdate(Update.frameOfTheMapMode);
				}
				else
				{
					if (!this.status.isGameOn())
						throw new Error("numberedFrame must happen in-game only");
					
					this.updateFlow.dispatchUpdate(Update.numberedFrame, this.frameCount);
					this.frameCount++;
					
					if (this.frameCount >= Game.FRAMES_PER_CYCLE)
						this.frameCount = 0;
				}
			}
		}
		
		update function gameFinished(key:int):void 
		{ 
			this.isFixed = true;
			
			this.frameCount = 0;
		}
		
	}
	
}