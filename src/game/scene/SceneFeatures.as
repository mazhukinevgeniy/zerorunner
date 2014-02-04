package game.scene 
{
	import data.viewers.GameConfig;
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
			this.width = Game.MAP_WIDTH;
			
			var j:int, i:int;
			
			/**
			 * Please note: this code strongly implies that Game.FALL === 0
			 *///TODO: check if it still does
			this.scene.clear();
			this.scene.length = this.width * this.width;
			
			
			/**
			 * Spawning random landscape
			 */
			for (j = 0; j < this.width; j++)
				for (i = 0; i < this.width; i++)
				{
					var rand:Number = Math.random();
					if (rand < 0.48)
						this.scene[i + j * this.width] = Game.SCENE_ROAD;
					else if (rand < 0.6)
						this.scene[i + j * this.width] = Game.SCENE_LAVA;
				}
			
			/**
			 * Protecting spawn
			 */
			for (i = 10; i < 14; i++)
				for (j = this.width - 14; j < this.width - 10; j++)
					this.scene[i + j * this.width] = Game.SCENE_ROAD;
			//TODO: get rid of this dirty hardcode
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			return this.scene[x + y * this.width];
		}
	}

}