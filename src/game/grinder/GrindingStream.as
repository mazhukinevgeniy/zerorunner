package game.grinder 
{
	import chaotic.core.IUpdateDispatcher;
	
	public class GrindingStream
	{
		public var front:int;
		public var id:int;
		
		internal var allowedGap:int;
		
		private var timeBeforeTheMove:int = 1;
		private var plannedMove:int;
		
		private var updateFlow:IUpdateDispatcher;
		
		
		public function GrindingStream(newID:int, flow:IUpdateDispatcher) 
		{
			this.id = newID;
			
			this.updateFlow = flow;
			
			this.front = 10 + Math.random() * 10;
			this.plannedMove = 1;
		}
		
		internal function newFront(value:int):void
		{
			if (this.front < value - this.allowedGap)
				this.timeBeforeTheMove = Math.min(this.timeBeforeTheMove, GrinderFeature.TIME_MIN);
		}
		
		internal function tick():void
		{
			this.timeBeforeTheMove--;
			
			if (this.timeBeforeTheMove == 0)
			{
				this.move(this.plannedMove);
				
				this.timeBeforeTheMove = GrinderFeature.TIME_MIN + Math.random() * 3;
				this.plannedMove = 1;
			}
		}
		
		private function move(distance:int):void
		{
			this.front += distance;
			this.updateFlow.dispatchUpdate(GrinderFeature.grindingStreamMoved, this.id, distance);
		}
	}

}