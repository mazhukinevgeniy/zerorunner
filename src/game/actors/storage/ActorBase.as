package game.actors.storage 
{
	import game.metric.CellXY;
	
	public class ActorBase 
	{
		internal var type:int;
		internal var id:int;
		
		internal var cell:CellXY;
		
		internal var speed:int;
		internal var remainingDelay:int;
		
		internal var active:Boolean;
		internal var hp:int;
		
		public function ActorBase() 
		{
			
		}
		
		
		public function get x():int
		{
			return this.cell.x;
		}
		public function get y():int
		{
			return this.cell.y;
		}
	}

}