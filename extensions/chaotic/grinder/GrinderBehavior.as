package chaotic.grinder 
{
	import chaotic.informers.IGiveInformers;
	import chaotic.metric.Metric;
	import chaotic.updates.IUpdateDispatcher;
	import chaotic.updates.IUpdateListener;
	import chaotic.updates.IUpdateListenerAdder;
	
	internal class GrinderBehavior implements IUpdateListener
	{
		private var updates:IUpdateDispatcher;
		private var streams:Vector.<GrindingStream>;
		
		public function GrinderBehavior() 
		{
			
		}
		
		public function addListenersTo(storage:IUpdateListenerAdder):void
		{
			storage.addUpdateListener(this, "restore");
			storage.addUpdateListener(this, "grindingStreamMoved");
			storage.addUpdateListener(this, "tick");
			storage.addUpdateListener(this, "getInformerFrom");
		}
		
		public function restore():void
		{
			this.streams = new Vector.<GrindingStream>(GrinderFeature.NUMBER, true);
			
			for (var i:int = 0; i < GrinderFeature.NUMBER; i++)
			{
				this.streams[i] = new GrindingStream(i, this.updates);
				
				this.streams[i].allowedGap = (Metric.CELLS_IN_VISIBLE_WIDTH + 1) / 2;
			}
			
			this.updates.dispatchUpdate("addGrinders", this.streams);
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
		
		/** As IInformerGetter: */
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.updates = table.getInformer(IUpdateDispatcher);
		}
	}

}