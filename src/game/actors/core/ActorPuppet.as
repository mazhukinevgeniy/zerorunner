package game.actors.core 
{
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	
	internal class ActorPuppet extends ActorReactor implements ICoordinated
	{
		internal var id:int;
		internal var hp:int;
		
		internal var moveSpeed:int;
		internal var movingCooldown:int;
		
		internal var actionSpeed:int;
		internal var actingCooldown:int;
		
		internal var cell:CellXY;
		
		internal var isActive:Boolean;
		
		public function ActorPuppet() 
		{
			
		}
		
		
		final public function get x():int
		{
			return this.cell.x;
		}
		final public function get y():int
		{
			return this.cell.y;
		}
		
		final public function get active():Boolean
		{
			return this.isActive;
		}
	}

}