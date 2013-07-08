package chaotic.actors.storage 
{
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	
	public class Puppet 
	{
		public var type:int;
		public var id:int;
		
		internal var cell:CellXY;
		
		public var speed:int;
		public var remainingDelay:int;
		public var data:Object;
		
		public var active:Boolean;
		public var hp:int;
		
		public var attemptedMove:DCellXY;
		
		public function Puppet(id:int, type:int, cell:CellXY) 
		{
			this.id = id;
			this.type = type;
			
			this.cell = cell.getCopy();
			
			this.remainingDelay = 0;
			this.data = new Object();
			
			this.active = true;
		}
		
		public function getCell():CellXY
		{
			return this.cell.getCopy();
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