package game.time 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import chaotic.informers.IStoreInformers;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	public class Time
	{
		private var fixed:Boolean = true;
		private var gameJuggler:Juggler;
		
		private var updateFlow:IUpdateDispatcher;
		
		public function Time(root:Sprite, flow:IUpdateDispatcher) 
		{
			this.gameJuggler = new Juggler();
			
			root.addEventListener(EnterFrameEvent.ENTER_FRAME, this.handleEnterFrame);
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.restore);
			flow.addUpdateListener(ZeroRunner.setPause);
			flow.addUpdateListener(ZeroRunner.gameOver);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			
			this.updateFlow = flow;
		}
		
		public function restore():void
		{
			this.gameJuggler.purge();
			
			this.fixed = false;
			
			this.gameJuggler.delayCall(this.prepareTick, ZeroRunner.TIME_BETWEEN_TICKS);
		}
		
		public function setPause(value:Boolean):void
		{
			this.fixed = value;
		}
		
		protected function handleEnterFrame(event:EnterFrameEvent):void 
		{
			if (!this.fixed)
			{
				this.gameJuggler.advanceTime(event.passedTime);
			}
		}
		
		private function prepareTick():void
		{
			this.updateFlow.dispatchUpdate(ZeroRunner.tick);
			
			this.gameJuggler.delayCall(this.prepareTick, ZeroRunner.TIME_BETWEEN_TICKS);
		}
		
		public function gameOver():void
		{
			this.fixed = true;
		}
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(Juggler, this.gameJuggler);
		}
	}
	
}