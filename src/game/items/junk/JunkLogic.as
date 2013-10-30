package game.items.junk 
{
	import game.GameElements;
	import game.items.ActivityCore;
	import game.items.ItemBase;
	import game.items.OccupationCore;
	
	internal class JunkLogic extends ItemBase
	{
		
		public function JunkLogic(elements:GameElements) 
		{
			super(elements, new ActivityCore(), new OccupationCore(), null);
			//TODO: use custom occupation core
		}
		
	}

}