package game.items.junk 
{
	import game.GameElements;
	import game.items.base.ItemBase;
	
	internal class JunkLogic extends ItemBase
	{
		
		public function JunkLogic(elements:GameElements) 
		{
			super(new JunkView(elements), elements, null);
			//TODO: must pass concrete existence to avoid flying junks
		}
		
	}

}