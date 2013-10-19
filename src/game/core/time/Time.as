package game.core.time 
{
	import data.StatusReporter;
	import flash.ui.Keyboard;
	import game.GameElements;
	import starling.animation.Juggler;
	import starling.events.EnterFrameEvent;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Time
	{
		private var frameCount:int = 0;
		
		
		private static const FRAMES_PER_CYCLE:int = 5;
		public static const TIME_BETWEEN_TICKS:Number = Time.FRAMES_PER_CYCLE / Main.FPS;
		
		
		private var _fixed:Boolean = true;
		
		private var updateFlow:IUpdateDispatcher;
		private var status:StatusReporter;
		private var gameJuggler:Juggler;
		
		private var pauseView:PauseView;
		
		public function Time(foundations:GameElements) 
		{
			foundations.displayRoot.addChild(this.pauseView = new PauseView());
			
			
			this.gameJuggler = foundations.juggler;
			this.status = foundations.database.status;
			
			foundations.displayRoot.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			foundations.flow.workWithUpdateListener(this);
			foundations.flow.addUpdateListener(Update.restore);
			foundations.flow.addUpdateListener(Update.keyUp);
			foundations.flow.addUpdateListener(Update.gameFinished);
			
			this.updateFlow = foundations.flow;
		}
		
		update function restore():void
		{
			this.fixed = false;
			
			this.frameCount = 0;
		}
		
		protected function handleEnterFrame(event:EnterFrameEvent):void 
		{
			if (!this.fixed)
			{
				this.gameJuggler.advanceTime(event.passedTime);
				
				if (this.frameCount < Time.FRAMES_PER_CYCLE)
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
		
		update function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.P && this.status.isGameOn)
			{
				this.fixed = !this.fixed;
			}
		}
		
		
		
		update function gameFinished(key:int):void 
		{ 
			this.gameJuggler.purge();
			
			this.fixed = true;
			this.pauseView.visible = false;
			
			this.frameCount = 0;
		}
		
		
		
		private function get fixed():Boolean
		{
			return this._fixed;
		}
		
		private function set fixed(value:Boolean):void
		{
			this.pauseView.visible = value;
			
			this._fixed = value;
		}
	}
	
}