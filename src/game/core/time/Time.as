package game.core.time 
{
	import flash.ui.Keyboard;
	import game.core.GameFoundations;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Time
	{
		private var FPS:int;
		private var tickFrame:int;
		private var redrawFrame:int;
		
		private var frameCount:int;
		
		private static var TBT:Number;
		public static function get TIME_BETWEEN_TICKS():Number
		{
			return Time.TBT;
		}
		 //TODO: remove from static
		
		private var _fixed:Boolean = true;
		private var gameJuggler:Juggler;
		
		private var updateFlow:IUpdateDispatcher;
		
		private var pauseView:PauseView;
		
		public function Time(root:Sprite, foundations:GameFoundations) 
		{
			root.addChild(this.pauseView = new PauseView());
			
			var flow:IUpdateDispatcher = foundations.flow;
			
			this.FPS = Starling.current.nativeStage.frameRate;
			this.tickFrame = this.FPS == 60 ? 5 : 2;
			this.redrawFrame = this.tickFrame - 1;
			
			this.frameCount = 0;
			
			Time.TBT = this.tickFrame / this.FPS;
			
			
			
			this.gameJuggler = foundations.juggler;
			
			root.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(Update.restore);
			flow.addUpdateListener(Update.gameStopped);
			flow.addUpdateListener(Update.keyUp);
			
			this.updateFlow = flow;
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
				
				if (this.frameCount == this.tickFrame)
				{
					this.frameCount = 0;
					
					this.updateFlow.dispatchUpdate(Update.tick);
				}
				else if (this.frameCount == this.redrawFrame)
				{
					this.frameCount++;
					
					this.updateFlow.dispatchUpdate(Update.redraw);
				}
				else
				{
					this.updateFlow.dispatchUpdate(Update.numberedFrame, this.frameCount);
					
					this.frameCount++;
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