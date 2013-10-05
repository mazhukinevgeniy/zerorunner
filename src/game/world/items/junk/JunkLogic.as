package game.world.items.junk 
{
	import game.core.GameFoundations;
	import game.world.items.ItemLogicBase;
	
	public class JunkLogic extends ItemLogicBase
	{
		
		public function JunkLogic(foundations:GameFoundations) 
		{
			super(new JunkView(foundations), foundations);
		}
		
	}

}