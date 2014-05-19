package model.projectiles 
{
	import utils.normalize;
	
	public class ShardCloud extends CloudBase
	{
		private var projectiles:Projectiles;
		
		private var tlcX:int;
		private var tlcY:int;
		
		private var width:int;
		private var height:int;
		
		public function ShardCloud(projectiles:Projectiles, x:int, y:int, width:int, height:int) 
		{
			this.projectiles = projectiles;
			
			this.tlcX = x;
			this.tlcY = y;
			this.width = width;
			this.height = height;
		}
		
		override internal function spawnProjectiles():void 
		{
			const NUMBER_OF_SPAWNS:int = 1;
			const NUMBER_OF_TRIES:int = 1;
			
			for (var i:int = 0; i < NUMBER_OF_SPAWNS; i++)
			{
				var x:int, y:int;
				
				for (var j:int = 0; j < NUMBER_OF_TRIES; j++)
				{
					x = normalize(this.tlcX + this.width * Math.random());
					y = normalize(this.tlcY + this.height * Math.random());
					
					if (!this.projectiles.getProjectile(x, y))
					{
						this.projectiles.getNewProjectile(Game.PROJECTILE_SHARD, x, y);
						
						break;
					}
				}
			}
		}
	}

}