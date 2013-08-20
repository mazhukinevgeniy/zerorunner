package game.world 
{
	import flash.utils.ByteArray;
	import game.IGame;
	import utils.updates.update;
	
	use namespace update;
	
	internal class SceneFeatures 
	{
		private var scene:ByteArray;
		private var width:int;
		
		private var game:IGame;
		
		public function SceneFeatures(game:IGame) 
		{
			this.scene = new ByteArray();
			
			this.game = game;
		}
		
		update function prerestore():void
		{
			this.width = ((this.game).getMapWidth() + 2) * Game.SECTOR_WIDTH;
			const secondJGoal:int = this.width - Game.SECTOR_WIDTH;
			
			var j:int, i:int;
			
			this.scene.length = this.width * this.width;
			
			
			for (j = 0; j < Game.SECTOR_WIDTH; j++)
				for (i = 0; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			for (; j < secondJGoal; j++)
			{
				for (i = 0; i < Game.SECTOR_WIDTH; i++)
					this.scene[i + j * this.width] = Game.FALL;
				for (; i < secondJGoal; i++)
					this.scene[i + j * this.width] = Math.random() < 0.4 ? Game.FALL : Game.ROAD;
				for (; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			}
			for (; j < this.width; j++)
				for (i = 0; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			
			//TODO: check if start and finish are okay
			/*
			update function cacheScene(cache:Vector.<int>, center:ICoordinated, width:int, height:int):void
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
			*/
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			return this.scene[x + y * this.width];
		}
	}

}