package game.scene 
{
	import data.viewers.GameConfig;
	import flash.utils.ByteArray;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Scene implements IScene
	{
		private var scene:ByteArray;
		
		public function Scene(flow:IUpdateDispatcher) 
		{
			this.scene = new ByteArray();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			var j:int, i:int;
			
			/**
			 * Please note: this code strongly implies that Game.FALL === 0
			 *///TODO: check if it still does
			this.scene.clear();
			this.scene.length = Game.MAP_WIDTH * Game.MAP_WIDTH;
			
			
			/**
			 * Spawning random landscape
			 */
			for (j = 0; j < Game.MAP_WIDTH; j++)
				for (i = 0; i < Game.MAP_WIDTH; i++)
				{
					var rand:Number = Math.random();
					if (rand < 0.48)
						this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_ROAD;
					else if (rand < 0.6)
						this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_LAVA;
				}
			
			/**
			 * Protecting spawn
			 */
			for (i = 10; i < 14; i++)
				for (j = Game.MAP_WIDTH - 14; j < Game.MAP_WIDTH - 10; j++)
					this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_ROAD;
			//TODO: get rid of this dirty hardcode
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			x = (x + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			y = (y + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			
			return this.scene[x + y * Game.MAP_WIDTH];
		}
	}

}