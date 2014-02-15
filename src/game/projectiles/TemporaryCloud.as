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
			const NUMBER_OF_SPAWNS:int = 2;
			const NUMBER_OF_TRIES:int = 4;
			
			const RADIUS:int = 5;
			
			const tlX:int = normalize(this.center.x - RADIUS);
			const tlY:int = normalize(this.center.y - RADIUS);
			
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