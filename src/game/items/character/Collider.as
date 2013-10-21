package game.items.character 
{
	import game.items.base.cores.CollisionCore;
	import game.items.base.ItemBase;
	
	internal class Collider extends CollisionCore
	{
		
		public function Collider() 
		{
			
		}
		
		override public function collideWith(blocker:ItemBase):void 
		{
			if (actor is ISolderable)
			{
				(actor as ISolderable).applySoldering(this.SOLDERING_POWER);
				
				//TODO: animate
			}
		}
	}

}