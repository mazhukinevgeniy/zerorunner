package game.items.technic 
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
				var tower:ISolderable = actor as ISolderable;
				tower.applySoldering(this.SOLDERING_POWER);
				
				if (tower.progress >= 1)
				{
					this.goal = null;
					this.points.removePointOfInterest(Game.TOWER, actor);
				}
			}
		}
	}

}