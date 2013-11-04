package game.items.junk 
{
	import game.GameElements;
	import game.items.MasterBase;
	import game.items.PuppetBase;
	
	internal class Junk extends PuppetBase
	{
		
		public function Junk(master:MasterBase, elements:GameElements) 
		{
			super(master, elements, null);
			//TODO: override occupations
		}
		
		override public function get type():int { return Game.ITEM_JUNK; }
	}

}