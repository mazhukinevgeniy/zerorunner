package game.actors.storage 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	
	public class Puppet 
	{
		
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
	}

}