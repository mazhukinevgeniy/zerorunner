package game.items.beacon 
{
	import game.core.metric.CellXY;
	import game.GameElements;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	
	internal class Beacon extends PuppetBase
	{
		
		public function Beacon(master:MasterBase, elements:GameElements, cell:CellXY) 
		{
			super(master, elements, null);
			//TODO: override occupations
		}
		
		
		
	}

}