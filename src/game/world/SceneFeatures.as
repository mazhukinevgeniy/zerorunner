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
		
		protected var game:IGame;
		
		public function SceneFeatures(game:IGame) 
		{
			this.scene = new ByteArray();
			
			this.game = game;
		}
		
		update function prerestore():void
		{
			this.width = ((this.game).mapWidth + 2) * Game.SECTOR_WIDTH;
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
			
			for (i = Game.SECTOR_WIDTH; i < Game.SECTOR_WIDTH + 4; i++)
				for (j = this.width - (Game.SECTOR_WIDTH + 4); j < secondJGoal; j++)
					this.scene[i + j * this.width] = Game.ROAD;
			
			for (i = this.width - (Game.SECTOR_WIDTH + 4); i < secondJGoal; i++)
				for (j = Game.SECTOR_WIDTH; j < Game.SECTOR_WIDTH + 4; j++)
					this.scene[i + j * this.width] = Game.ROAD;
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			return this.scene[x + y * this.width];
		}
	}

}