package game.hud.map 
{
	import flash.utils.ByteArray;
	import game.IGame;
	import game.utils.GameFoundations;
	import starling.display.QuadBatch;
	import utils.updates.update;
	
	public class MapFeature 
	{
		private const NOT_VISITED:int = 0;
		private const VISITED:int = 1;
		
		private var visited:ByteArray;
		private var width:int;
		
		private var game:IGame;
		
		
		private var container:QuadBatch;
		
		public function MapFeature(foundations:GameFoundations) 
		{
			this.visited = new ByteArray();
			
			this.game = foundations.game;
			
			foundations.flow.workWithUpdateListener(this);
			foundations.flow.addUpdateListener(Update.prerestore);
			
			foundations.flow.dispatchUpdate(Update.addToTheHUD, this.container = new QuadBatch());
		}
		
		update function prerestore():void
		{
			this.width = ((this.game).getMapWidth() + 2) * Game.SECTOR_WIDTH;
			
			var length:int = this.visited.length = this.width * this.width;
			
			for (var i:int = 0; i < length; i++)
				this.visited[i] = this.NOT_VISITED;
		}
	}

}