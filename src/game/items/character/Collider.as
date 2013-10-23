package game.items.character 
{
	import game.items.base.cores.CollisionCore;
	import game.items.base.ItemBase;
	import game.items.items_internal;
	
	use namespace items_internal;
	
	internal class Collider extends CollisionCore
	{
		
		public function Collider() 
		{
			
		}
		
		override public function collideWith(blocker:ItemBase):void 
		{
			if (blocker.contraption)
			{
				blocker.contraption.applySoldering(this.SOLDERING_POWER);
				
				//TODO: animate
			}
		}
	}

}