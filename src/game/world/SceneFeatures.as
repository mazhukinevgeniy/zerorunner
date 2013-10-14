package game.world 
{
	import data.structs.GameConfig;
	import flash.utils.ByteArray;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class SceneFeatures implements IScene
	{
		private var scene:ByteArray;
		private var width:int;
		
		public function SceneFeatures(flow:IUpdateDispatcher) 
		{
			this.scene = new ByteArray();
			
			this.game = game;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			const sectorWidth:int = (this.game).sectorWidth;
			
			this.width = ((this.game).mapWidth + 2) * sectorWidth;
			const secondJGoal:int = this.width - sectorWidth;
			
			var j:int, i:int;
			
			this.scene.length = this.width * this.width;
			
			
			
			for (j = 0; j < sectorWidth; j++)
				for (i = 0; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			for (; j < secondJGoal; j++)
			{
				for (i = 0; i < sectorWidth; i++)
					this.scene[i + j * this.width] = Game.FALL;
				for (; i < secondJGoal; i++)
					this.scene[i + j * this.width] = Math.random() < 0.4 ? Game.FALL : Game.ROAD;
				for (; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			}
			for (; j < this.width; j++)
				for (i = 0; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			
			for (i = sectorWidth; i < sectorWidth + 4; i++)
				for (j = this.width - (sectorWidth + 4); j < secondJGoal; j++)
					this.scene[i + j * this.width] = Game.ROAD;
			
			for (i = this.width - (sectorWidth + 4); i < secondJGoal; i++)
				for (j = sectorWidth; j < sectorWidth + 4; j++)
					this.scene[i + j * this.width] = Game.ROAD;
			
			for (i = 0; i < this.width * this.width; i++)
				if (this.scene[i] == Game.ROAD && Math.random() < 0.2)
					this.scene[i] = Game.BASALT;
			
			//TODO: can optimize
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			return this.scene[x + y * this.width];
		}
	}

}