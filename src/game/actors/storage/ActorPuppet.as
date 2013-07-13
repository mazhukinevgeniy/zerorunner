package game.actors.storage 
{
	import game.metric.CellXY;
	
	internal class ActorPuppet 
	{
		
		internal var type:int;
		internal var id:int;
		
		internal var speed:int;
		internal var movingCooldown:int;
		
		internal var actionSpeed:int;
		internal var actingCooldown:int;
		
		internal var cell:CellXY;
		
		internal var active:Boolean;
		
		public function ActorPuppet() 
		{
			
		}
		
		
		final protected function get x():int
		{
			return this.cell.x;
		}
		final protected function get y():int
		{
			return this.cell.y;
		}
		
	}

}