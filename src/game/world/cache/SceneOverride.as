package game.world.cache 
{
	import game.utils.metric.CellXY;
	import game.utils.metric.ICoordinated;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class SceneOverride 
	{
		private const RADIUS:int = 4;
		
		public function SceneOverride(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.cacheScene);
		}
		
		update function cacheScene(cache:Vector.<int>, center:ICoordinated, width:int, height:int):void
		{
			var tlcX:int = center.x - width / 2;
			var tlcY:int = center.y - height / 2;
			
			var center1:CellXY = ActorsFeature.SPAWN_CELL;
			
			if (center1.x + this.RADIUS > tlcX &&
				center1.y + this.RADIUS > tlcY &&
				center1.x - this.RADIUS < tlcX + width &&
				center1.y - this.RADIUS < tlcY + height)
			{
				var xTop:int = Math.min(center1.x + this.RADIUS, tlcX + width);
				var yTop:int = Math.min(center1.y + this.RADIUS, tlcY + height);
				
				for (var i:int = Math.max(tlcX, center1.x - this.RADIUS); i < xTop; i++)
					for (var j:int = Math.max(tlcY, center1.y - this.RADIUS); j < yTop; j++)
					{
						cache[i - tlcX + (j - tlcY) * width] = SceneFeature.ROAD;
					}
			}
		}
	}

}