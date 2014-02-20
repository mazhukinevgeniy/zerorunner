package game.items.generator 
{
	import game.GameElements;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	import game.metric.ICoordinated;
	
	internal class Generator extends PuppetBase
	{
		
		public function Generator(master:MasterBase, elements:GameElements, cell:ICoordinated) 
		{
			super(master, elements, cell);
		}
		
		override public function get type():int { return Game.ITEM_GENERATOR; }
		
		override protected function get isPassive():Boolean { return true; }
	}

}