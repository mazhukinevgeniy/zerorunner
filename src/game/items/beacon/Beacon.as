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
			super(master, elements, cell);
			//TODO: override occupations
		}
		
		override public function get type():int { return Game.ITEM_BEACON; }
		
		override protected function get isPassive():Boolean { return true; }
	}

}