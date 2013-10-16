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
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.width = config.width + 2 * Game.BORDER_WIDTH;
			
			const secondJGoal:int = this.width - Game.BORDER_WIDTH;
			
			var j:int, i:int;
			
			this.scene.length = this.width * this.width;
			
			
			
			for (j = 0; j < Game.BORDER_WIDTH; j++)
				for (i = 0; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			for (; j < secondJGoal; j++)
			{
				for (i = 0; i < Game.BORDER_WIDTH; i++)
					this.scene[i + j * this.width] = Game.FALL;
				for (; i < secondJGoal; i++)
					this.scene[i + j * this.width] = Math.random() < 0.4 ? Game.FALL : Game.ROAD;
				for (; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			}
			for (; j < this.width; j++)
				for (i = 0; i < this.width; i++)
					this.scene[i + j * this.width] = Game.FALL;
			
			for (i = Game.BORDER_WIDTH; i < Game.BORDER_WIDTH + 4; i++)
				for (j = this.width - (Game.BORDER_WIDTH + 4); j < secondJGoal; j++)
					this.scene[i + j * this.width] = Game.ROAD;
			
			for (i = this.width - (Game.BORDER_WIDTH + 4); i < secondJGoal; i++)
				for (j = Game.BORDER_WIDTH; j < Game.BORDER_WIDTH + 4; j++) //TODO: does it makes sense at all? +4, i mean? 
					this.scene[i + j * this.width] = Game.ROAD;
			
			for (i = 0; i < this.width * this.width; i++)
				if (this.scene[i] == Game.ROAD && Math.random() < 0.2)
					this.scene[i] = Game.LAVA;
			
			//TODO: can optimize
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			return this.scene[x + y * this.width];
		}
	}

}