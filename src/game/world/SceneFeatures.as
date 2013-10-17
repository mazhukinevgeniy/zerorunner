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
			
			/**
			 * Please note: this code strongly implies that Game.FALL === 0
			 */
			this.scene.clear();
			this.scene.length = this.width * this.width;
			
			
			/**
			 * Spawning random ground
			 */
			for (j = Game.BORDER_WIDTH; j < secondJGoal; j++)
				for (i = Game.BORDER_WIDTH; i < secondJGoal; i++)
					if (Math.random() < 0.4)
						this.scene[i + j * this.width] = Game.ROAD;
			
			/**
			 * Adding lava
			 */
			for (i = 0; i < this.width * this.width; i++)
				if (this.scene[i] == Game.ROAD && Math.random() < 0.2)
					this.scene[i] = Game.LAVA;
			
			/**
			 * Protecting spawn
			 */
			for (i = Game.BORDER_WIDTH; i < Game.BORDER_WIDTH + 4; i++)
				for (j = this.width - (Game.BORDER_WIDTH + 4); j < secondJGoal; j++)
					this.scene[i + j * this.width] = Game.ROAD;
			
			/**
			 * Protecting the end of the world
			 */
			for (i = this.width - (Game.BORDER_WIDTH + 4); i < secondJGoal; i++)
				for (j = Game.BORDER_WIDTH; j < Game.BORDER_WIDTH + 4; j++) 
					this.scene[i + j * this.width] = Game.ROAD;
			
			//TODO: can optimize
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			return this.scene[x + y * this.width];
		}
	}

}