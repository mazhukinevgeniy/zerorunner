package game.actors.storage 
{
	import chaotic.core.IUpdateDispatcher;
	import game.metric.CellXY;
	
	public class ActorBase 
	{
		internal static var flow:IUpdateDispatcher;
		internal static var searcher:ISearcher;
		
		
		internal var type:int;
		internal var id:int;
		
		internal var cell:CellXY;
		
		internal var active:Boolean;
		
		public function ActorBase(configuration:XML) 
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