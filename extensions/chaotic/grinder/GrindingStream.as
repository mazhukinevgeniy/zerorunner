package chaotic.grinder 
{
	import chaotic.core.ChaoticFeature;
	import chaotic.updates.Update;
	
	public class GrindingStream extends ChaoticFeature
	{
		public var front:int;
		public var id:int;
		
		internal var allowedGap:int;
		
		private var timeBeforeTheMove:int = 1;
		private var plannedMove:int;
		
		
		public function GrindingStream(newID:int) 
		{
			this.id = newID;
			
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
				
				this.timeBeforeTheMove = GrinderFeature.TIME_MIN + Math.random() * 15;
				this.plannedMove = 1;
			}
		}
		
		private function move(distance:int):void
		{
			this.front += distance;
			this.dispatchUpdate(new Update("grindingStreamMoved", this.id, distance));
		}
	}

}