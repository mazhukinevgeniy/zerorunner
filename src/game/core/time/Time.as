package game.core.time 
{
	import flash.ui.Keyboard;
	import game.core.GameFoundations;
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
		private var gameJuggler:Juggler;
		
		private var updateFlow:IUpdateDispatcher;
		
		private var pauseView:PauseView;
		
		public function Time(foundations:GameFoundations) 
		{
			foundations.displayRoot.addChild(this.pauseView = new PauseView());
			
			
			this.gameJuggler = foundations.juggler;
			
			foundations.displayRoot.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			foundations.flow.workWithUpdateListener(this);
			
			foundations.flow.addUpdateListener(Update.restore);
			foundations.flow.addUpdateListener(Update.gameStopped);
			foundations.flow.addUpdateListener(Update.keyUp);
			
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
		
		update function gameStopped():void
		{
			this.gameJuggler.purge();
			
			this.fixed = true;
			
			this.frameCount = 0;
		}
		
		update function keyUp(keyCode:uint):void
		{
			if (keyCode == Keyboard.P)
			{
				this.fixed = !this.fixed;
			}
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