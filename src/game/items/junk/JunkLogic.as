package game.items.junk 
{
	import game.GameElements;
	import game.items.ItemBase;
	import game.items.OccupationCore;
	
	internal class JunkLogic extends ItemBase
	{
		
		public function JunkLogic(elements:GameElements) 
		{
			super(elements, new OccupationCore(), null);
			//TODO: use custom occupation core
		}
		
	}

}