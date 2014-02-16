package game.hud 
{
	import data.viewers.GameConfig;
	import flash.utils.ByteArray;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.scene.IScene;
	import starling.display.Quad;
	import starling.display.QuadBatch;
	import utils.updates.update;
	
	use namespace update;
	
	public class MapFeature 
	{
		private const NOT_VISITED:int = 0;
		private const VISITED:int = 1;
		
		private var visited:ByteArray;
		
		private var scene:IScene;
		private var center:ICoordinated;
		
		private var container:QuadBatch;
		
		private var road:Quad;
		
		public function MapFeature(elements:GameElements) 
		{
			this.visited = new ByteArray();
			
			this.scene = elements.scene;
			this.road = new Quad(2, 2, 0x999900);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.restore);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			this.container = new QuadBatch();
			elements.displayRoot.addChild(this.container);
		}
		
		update function restore(config:GameConfig):void
		{			
			var length:int = this.visited.length = Game.MAP_WIDTH * Game.MAP_WIDTH;
			
			for (var i:int = 0; i < length; i++)
				this.visited[i] = this.NOT_VISITED;
				/* OPTIMIZABLE */
		}
		
		update function setCenter(center:ICoordinated):void//TODO: use this update where it will be of use
		{
			this.center = center;
			
			this.container.reset();
		}
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				var iGoal:int = this.center.x + 8;
				var jGoal:int = this.center.y + 6;
				
				for (var i:int = this.center.x - 7; i < iGoal; i++)
					for (var j:int = this.center.y - 5; j < jGoal; j++)
					{
						if (this.visited[normalize(i) + Game.MAP_WIDTH * normalize(j)] == this.NOT_VISITED)
						{
							this.visited[normalize(i) + Game.MAP_WIDTH * normalize(j)] = this.VISITED;
							
							if (this.scene.getSceneCell(i, j) != Game.SCENE_FALL)
							{
								this.road.x = 2 * normalize(i);
								this.road.y = 2 * normalize(j);
								
								this.container.addQuad(this.road);
							}
						}
					}
			}
		}
		
		update function quitGame():void
		{
			this.container.reset();
			
			this.visited.clear();
		}
	}

}