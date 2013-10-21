package game.items.character 
{
	import game.items.base.cores.ExistenceCore;
	
	internal class Existence extends ExistenceCore
	{
		
		public function Existence() 
		{
			
		}
		
		override public function applyDestruction():void
		{
			this.flow.dispatchUpdate(Update.gameFinished, Game.LOST);
		}
	}

}