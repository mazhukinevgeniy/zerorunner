package chaotic.grinder 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.game.ChaoticGame;
	import chaotic.informers.IGiveInformers;
	import chaotic.metric.Metric;
	
	internal class GrinderBehavior
	{
		private var updates:IUpdateDispatcher;
		private var streams:Vector.<GrindingStream>;
		
		public function GrinderBehavior(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ChaoticGame.restore);
			flow.addUpdateListener(GrinderFeature.grindingStreamMoved);
			flow.addUpdateListener(ChaoticGame.tick);
			
			this.updates = flow;
		}
		
		public function restore():void
		{
			this.streams = new Vector.<GrindingStream>(GrinderFeature.NUMBER, true);
			
			for (var i:int = 0; i < GrinderFeature.NUMBER; i++)
			{
				this.streams[i] = new GrindingStream(i, this.updates);
				
				this.streams[i].allowedGap = (Metric.CELLS_IN_VISIBLE_WIDTH + 1) / 2;
			}
			
			this.updates.dispatchUpdate(GrinderFeature.addGrinders, this.streams);
		}
		
		/** As IGrinderSubscriber: */
		public function grindingStreamMoved(id:int, change:int):void
		{
			var length:int = this.streams.length;
			this.streams[(id - 1 + length) % length].newFront(this.streams[id].front);
			this.streams[(id + 1) % length].newFront(this.streams[id].front);
		}
		
		/** As ITimed: */
		public function tick():void
		{
			var length:int = this.streams.length;
			
			for (var i:int = 0; i < length; i++)
				this.streams[i].tick();
		}
	}

}