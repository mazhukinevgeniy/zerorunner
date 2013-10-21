package game.items.junk 
{
	import game.GameElements;
	import game.items.base.ItemBase;
	
	internal class JunkLogic extends ItemBase
	{
		
		public function JunkLogic(foundations:GameElements) 
		{
			super(new JunkView(foundations), null);
		}
		
	}

}