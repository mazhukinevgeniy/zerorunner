package chaotic.grinder 
{
	import chaotic.core.ChaoticFeature;
	import chaotic.metric.Metric;
	import chaotic.updates.IGrinderSubscriber;
	import chaotic.updates.IRestorable;
	import chaotic.updates.ITimed;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.updates.Update;
	
	internal class GrinderBehavior extends ChaoticFeature implements IRestorable, ITimed, IGrinderSubscriber
	{
		private var updates:IUpdateDispatcher;
		private var streams:Vector.<GrindingStream>;
		
		public function GrinderBehavior() 
		{
			
		}
		
		public function restore():void
		{
			this.streams = new Vector.<GrindingStream>(GrinderFeature.NUMBER, true);
			
			for (var i:int = 0; i < GrinderFeature.NUMBER; i++)
			{
				this.streams[i] = new GrindingStream(i);
				
				this.streams[i].setUpdateFlow(this.updates);
				this.streams[i].allowedGap = (Metric.CELLS_IN_VISIBLE_WIDTH + 1) / 2;
			}
			
			this.dispatchUpdate(new Update("addGrinders", this.streams));
		}
		
		override public function setUpdateFlow(item:IUpdateDispatcher):void
		{
			this.updates = item;
			super.setUpdateFlow(item);
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