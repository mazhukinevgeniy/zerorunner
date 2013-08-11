package game.scene 
{
	import game.actors.ActorsFeature;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import game.world.SearcherFeature;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class SceneOverride 
	{
		private var center1:CellXY = ActorsFeature.SPAWN_CELL;
		private const RADIUS:int = 4;
		
		public function SceneOverride(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(SearcherFeature.cacheScene);
		}
		
		update function cacheScene(cache:Vector.<int>, center:ICoordinated, width:int, height:int):void
		{
			var tlcX:int = center.x - width / 2;
			var tlcY:int = center.y - height / 2;
			
			if (this.center1.x + this.RADIUS > tlcX &&
				this.center1.y + this.RADIUS > tlcY &&
				this.center1.x - this.RADIUS < tlcX + width &&
				this.center1.y - this.RADIUS < tlcY + height)
			{
				var xTop:int = Math.min(this.center1.x + this.RADIUS, tlcX + width);
				var yTop:int = Math.min(this.center1.y + this.RADIUS, tlcY + height);
				
				for (var i:int = Math.max(tlcX, this.center1.x - this.RADIUS); i < xTop; i++)
					for (var j:int = Math.max(tlcY, this.center1.y - this.RADIUS); j < yTop; j++)
					{
						cache[i - tlcX + (j - tlcY) * width] = SceneFeature.ROAD;
					}
			}
		}
	}

}