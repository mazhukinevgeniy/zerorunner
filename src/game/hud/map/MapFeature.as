package game.hud.map 
{
	import flash.utils.ByteArray;
	import game.IGame;
	import game.utils.GameFoundations;
	import game.utils.metric.ICoordinated;
	import game.world.ISearcher;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import utils.updates.update;
	
	use namespace update;
	
	public class MapFeature 
	{
		private const NOT_VISITED:int = 0;
		private const VISITED:int = 1;
		
		private var visited:ByteArray;
		private var width:int;
		
		private var game:IGame;
		private var world:ISearcher;
		private var center:ICoordinated;
		
		private var container:QuadBatch;
		
		private var road:Quad;
		
		public function MapFeature(foundations:GameFoundations) 
		{
			this.visited = new ByteArray();
			
			this.game = foundations.game;
			this.world = foundations.world;
			this.road = new Quad(1, 1, 0xFF0000);
			
			foundations.flow.workWithUpdateListener(this);
			foundations.flow.addUpdateListener(Update.prerestore);
			foundations.flow.addUpdateListener(Update.setCenter);
			foundations.flow.addUpdateListener(Update.tick);
			
			foundations.flow.dispatchUpdate(Update.addToTheHUD, this.container = new QuadBatch());
		}
		
		update function prerestore():void
		{
			this.width = ((this.game).getMapWidth() + 2) * Game.SECTOR_WIDTH;
			
			var length:int = this.visited.length = this.width * this.width;
			
			for (var i:int = 0; i < length; i++)
				this.visited[i] = this.NOT_VISITED;
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.center = center;
			
			this.container.reset();
		}
		
		update function tick():void
		{
			var iGoal:int = this.center.x + 8;
			var jGoal:int = this.center.y + 6;
			
			for (var i:int = this.center.x - 7; i < iGoal; i++)
				for (var j:int = this.center.y - 5; j < jGoal; j++)
				{
					if (this.visited[i + this.width * j] == this.NOT_VISITED)
					{
						this.visited[i + this.width * j] = this.VISITED;
						
						if (this.world.getSceneCell(i, j) == Game.ROAD)
						{
							this.road.x = i;
							this.road.y = j;
							
							this.container.addQuad(this.road);
						}
					}
				}
		}
	}

}