package game.projectiles 
{
	import data.viewers.GameConfig;
	import game.core.metric.CellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.points.IPointCollector;
	import utils.updates.update;
	
	internal class TemporaryCloud extends CloudBase
	{
		private var center:ICoordinated;
		
		
		private var points:IPointCollector;
		private var projectiles:Projectiles;
		
		private var tmpCell:CellXY;
		
		public function TemporaryCloud(elements:GameElements, projectiles:Projectiles) 
		{
			this.points = elements.pointsOfInterest;
			this.projectiles = projectiles;
			
			this.tmpCell = new CellXY(0, 0);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
		}
		
		override internal function spawnProjectiles():void 
		{
			const NUMBER_OF_SPAWNS:int = 1;
			const NUMBER_OF_TRIES:int = 1;
			
			const RADIUS:int = 9; //TODO: check this hardcode
			
			const tlX:int = normalize(this.center.x - RADIUS);
			const tlY:int = normalize(this.center.y - RADIUS);
			
			for (var i:int = 0; i < NUMBER_OF_SPAWNS; i++)
			{
				var x:int, y:int;
				
				for (var j:int = 0; j < NUMBER_OF_TRIES; j++)
				{
					x = normalize(tlX + (2 * RADIUS + 1) * Math.random());
					y = normalize(tlY + (2 * RADIUS + 1) * Math.random());
					
					if (!this.projectiles.getProjectile(x, y))
					{
						this.projectiles.getNewProjectile(Game.PROJECTILE_SHARD, x, y);
						
						break;
					}
				}
				
				//TODO: spawn projectiles
			}
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.center = this.points.getCharacter();
		}
	}

}