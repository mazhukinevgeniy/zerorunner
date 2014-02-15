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
		}
		
		override internal function spawnProjectiles():void 
		{
			const NUMBER_OF_SPAWNS:int = 2;
			const NUMBER_OF_TRIES:int = 4;
			
			const RADIUS:int = 5;
			
			const tlX:int = (this.center.x - RADIUS + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			const tlY:int = (this.center.y - RADIUS + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			
			for (var i:int = 0; i < NUMBER_OF_SPAWNS; i++)
			{
				
				//TODO: spawn projectiles
			}
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.center = this.points.getCharacter();
		}
	}

}