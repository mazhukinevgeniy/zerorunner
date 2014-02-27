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
			flow.addUpdateListener(Update.restore);
		}
		
		update function restore(config:GameConfig):void
		{
			var j:int, i:int, k:int;
			
			this.scene.clear();
			this.scene.length = Game.MAP_WIDTH * Game.MAP_WIDTH;
			
			for (i = 0; i < Game.MAP_WIDTH * Game.MAP_WIDTH; i++)
				this.scene[i] = Game.SCENE_GROUND;
			
			/* Everything is solid ground by now */
			
			const NUMBER_OF_CANYONS:int = Game.MAP_WIDTH * Game.MAP_WIDTH * 0.05;
			
			for (k = 0; k < NUMBER_OF_CANYONS; k++)
			{
				i = Math.random() * Game.MAP_WIDTH;
				j = Math.random() * Game.MAP_WIDTH;
				
				while (Math.random() < 0.65)
				{
					this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_FALL;
					this.scene[(i + j * Game.MAP_WIDTH + 1) % (Game.MAP_WIDTH * Game.MAP_WIDTH)] = Game.SCENE_FALL;
					this.scene[(i + j * Game.MAP_WIDTH + Game.MAP_WIDTH) % (Game.MAP_WIDTH * Game.MAP_WIDTH)] = Game.SCENE_FALL;
					this.scene[(i + j * Game.MAP_WIDTH + Game.MAP_WIDTH + 1) % (Game.MAP_WIDTH * Game.MAP_WIDTH)] = Game.SCENE_FALL;
					
					if (Math.random() < 0.25)
						i = normalize(i + 1);
					else if (Math.random() < 0.33)
						i = normalize(i - 1);
					else if (Math.random() < 0.5)
						j = normalize(j + 1);
					else
						j = normalize(j - 1);
				}
			}
			
			/* We have canyons now */
			
			for (j = 0; j < Game.MAP_WIDTH; j++)
				for (i = 0; i < Game.MAP_WIDTH; i++)
					if ((i % 15) + (j % 15) == 0)//TODO: check that hardcode
					{
						if (this.scene[i + j * Game.MAP_WIDTH] == Game.SCENE_GROUND)
							this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_SOLID_GROUND;
					}
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.scene[x + y * Game.MAP_WIDTH];
		}
		
		//TODO: make sure scene is effectively stored
		//TODO: think if you ever need to modify the scene itself; if you don't, it's great
	}

}