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
			var j:int, i:int, k:int;
			
			this.scene.clear();
			this.scene.length = Game.MAP_WIDTH * Game.MAP_WIDTH;
			
			for (i = 0; i < Game.MAP_WIDTH * Game.MAP_WIDTH; i++)
				this.scene[i] = Game.SCENE_ROAD;
			
			/* Everything is solid ground by now */
			
			const NUMBER_OF_CANYONS:int = Game.MAP_WIDTH * Game.MAP_WIDTH * 0.05;
			
			for (k = 0; k < NUMBER_OF_CANYONS; k++)
			{
				i = Math.random() * Game.MAP_WIDTH;
				j = Math.random() * Game.MAP_WIDTH;
				
				while (Math.random() < 0.95)
				{
					this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_FALL;
					
					if (Math.random() < 0.25)
						i = (i + 1 + Game.MAP_WIDTH) % Game.MAP_WIDTH;
					else if (Math.random() < 0.33)
						i = (i - 1 + Game.MAP_WIDTH) % Game.MAP_WIDTH;
					else if (Math.random() < 0.5)
						j = (j + 1 + Game.MAP_WIDTH) % Game.MAP_WIDTH;
					else
						j = (j - 1 + Game.MAP_WIDTH) % Game.MAP_WIDTH;
				}
			}
			
			/* We have canyons now */
			
			const NUMBER_OF_LAVA_LAKES:int = Game.MAP_WIDTH * Game.MAP_WIDTH * 0.001;
			
			for (k = 0; k < NUMBER_OF_CANYONS; k++)
			{
				i = Math.random() * Game.MAP_WIDTH;
				j = Math.random() * Game.MAP_WIDTH;
				
				while (Math.random() < 0.65)
				{
					this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_LAVA;
					this.scene[(i + j * Game.MAP_WIDTH + 1) % (Game.MAP_WIDTH * Game.MAP_WIDTH)] = Game.SCENE_LAVA;
					this.scene[(i + j * Game.MAP_WIDTH + Game.MAP_WIDTH) % (Game.MAP_WIDTH * Game.MAP_WIDTH)] = Game.SCENE_LAVA;
					this.scene[(i + j * Game.MAP_WIDTH + Game.MAP_WIDTH + 1) % (Game.MAP_WIDTH * Game.MAP_WIDTH)] = Game.SCENE_LAVA;
					
					if (Math.random() < 0.25)
						i = (i + 1 + Game.MAP_WIDTH) % Game.MAP_WIDTH;
					else if (Math.random() < 0.33)
						i = (i - 1 + Game.MAP_WIDTH) % Game.MAP_WIDTH;
					else if (Math.random() < 0.5)
						j = (j + 1 + Game.MAP_WIDTH) % Game.MAP_WIDTH;
					else
						j = (j - 1 + Game.MAP_WIDTH) % Game.MAP_WIDTH;
				}
			}
			
			/* We have lava lakes now */
			
			for (j = 0; j < Game.MAP_WIDTH; j++)
				for (i = 0; i < Game.MAP_WIDTH; i++)
					if (Math.random() < 0.05)
					{
						var rand:Number = Math.random();
						if (rand < 0.48)
							this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_ROAD;
						else if (rand < 0.6)
							this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_LAVA;
					}
			
			/* Added random deviations here */
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			x = (x + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			y = (y + Game.MAP_WIDTH) % Game.MAP_WIDTH;
			
			return this.scene[x + y * Game.MAP_WIDTH];
		}
	}

}