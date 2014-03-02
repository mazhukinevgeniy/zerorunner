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
			
			var length:int;
			
			this.scene.clear();
			this.scene.length = Game.MAP_WIDTH * Game.MAP_WIDTH;
			
			for (i = 0; i < Game.MAP_WIDTH * Game.MAP_WIDTH; i++)
				this.scene[i] = Game.SCENE_GROUND;
			
			/* Everything is solid ground by now */
			
			if (Game.MAP_WIDTH % 3 != 0)
				throw new Error("can't generate map");
			
			for (i = 0; i < Game.MAP_WIDTH / 3; i++) /* filling rows */
			{
				for (j = 0; j < Game.MAP_WIDTH; j++)
				{
					if (Math.random() > 0.4) /* adding falls */
					{
						length = 3 + Math.random() * 3;
						
						if (j + length >= Game.MAP_WIDTH)
						{
							length = Game.MAP_WIDTH - j;
							
							if (this.getSceneCell(0, i * 3) == Game.SCENE_GROUND)
								if (this.getSceneCell(1, i * 3) == Game.SCENE_FALL)
									length--;
						}
						
						if (length < 3)
							length = 0;
						else
							for (k = 0; k < length; k++)
							{
								if (j >= Game.MAP_WIDTH)
								{
									throw new Error();
								}
								
								this.scene[j + (i * 3 + 0) * Game.MAP_WIDTH] = Game.SCENE_FALL;
								this.scene[j + (i * 3 + 1) * Game.MAP_WIDTH] = Game.SCENE_FALL;
								this.scene[j + (i * 3 + 2) * Game.MAP_WIDTH] = Game.SCENE_FALL;
								
								j++;
							}
						
						j++;
					}
					else
					{
						j++;
					}
				}
			}
			
			var lengthAbove:int;
			var startJ:int;
			
			for (i = 0; i < Game.MAP_WIDTH / 3; i++)
			{
				for (j = 0; j < Game.MAP_WIDTH; j++)
				{
					var locI:int = i * 3;
					var prevI:int = normalize(locI - 1);
					
					if (this.scene[j + locI * Game.MAP_WIDTH] == Game.SCENE_GROUND)
						if ((this.getSceneCell(j - 1, prevI) == Game.SCENE_FALL) &&
							(this.getSceneCell(j, prevI) == Game.SCENE_FALL) &&
							(this.getSceneCell(j + 1, prevI) == Game.SCENE_FALL)) //three falls above
						{
							if ((this.getSceneCell(j - 1, locI) == Game.SCENE_FALL) ||
								(this.getSceneCell(j + 1, locI) == Game.SCENE_FALL)) //we have bad angle here
							{
								lengthAbove = 3;
								startJ = j - 1;
								
								k = 2; 
								while (this.getSceneCell(j + k, prevI) == Game.SCENE_FALL)
								{   
									k++;
									lengthAbove++;
								}
								
								k = 2; 
								while (this.getSceneCell(j - k, prevI) == Game.SCENE_FALL)
								{   
									k++;
									lengthAbove++;
									startJ--;
								}
								
								for (k = startJ; k < startJ + lengthAbove; k++)
								{
									this.scene[normalize(k) + (prevI - 0) * Game.MAP_WIDTH] = Game.SCENE_GROUND;
									this.scene[normalize(k) + (prevI - 1) * Game.MAP_WIDTH] = Game.SCENE_GROUND;
									this.scene[normalize(k) + (prevI - 2) * Game.MAP_WIDTH] = Game.SCENE_GROUND;
								}
							}
						}
					
					if (this.scene[j + prevI * Game.MAP_WIDTH] == Game.SCENE_GROUND)
						if ((this.getSceneCell(j - 1, locI) == Game.SCENE_FALL) &&
							(this.getSceneCell(j, locI) == Game.SCENE_FALL) &&
							(this.getSceneCell(j + 1, locI) == Game.SCENE_FALL)) 
						{
							if ((this.getSceneCell(j - 1, prevI) == Game.SCENE_FALL) ||
								(this.getSceneCell(j + 1, prevI) == Game.SCENE_FALL)) //we have bad angle here
							{
								lengthAbove = 3;
								startJ = j - 1;
								
								k = 2; 
								while (this.getSceneCell(j + k, locI) == Game.SCENE_FALL)
								{   
									k++;
									lengthAbove++;
								}
								
								k = 2; 
								while (this.getSceneCell(j - k, locI) == Game.SCENE_FALL)
								{   
									k++;
									lengthAbove++;
									startJ--;
								}
								
								for (k = startJ; k < startJ + lengthAbove; k++)
								{
									this.scene[normalize(k) + (locI + 0) * Game.MAP_WIDTH] = Game.SCENE_GROUND;
									this.scene[normalize(k) + (locI + 1) * Game.MAP_WIDTH] = Game.SCENE_GROUND;
									this.scene[normalize(k) + (locI + 2) * Game.MAP_WIDTH] = Game.SCENE_GROUND;
								}
							}
						}
				}
			}
			
			/* We have canyons now */
			
			var up:Boolean, down:Boolean, left:Boolean, right:Boolean;
			var fallsNearby:int;
			
			for (j = 0; j < Game.MAP_WIDTH; j++)
				for (i = 0; i < Game.MAP_WIDTH; i++)
				{
					if (this.scene[i + j * Game.MAP_WIDTH] == Game.SCENE_FALL)
					{
						up = (this.getSceneCell(i, j - 1) != Game.SCENE_GROUND);
						down = (this.getSceneCell(i, j + 1) != Game.SCENE_GROUND);
						left = (this.getSceneCell(i - 1, j) != Game.SCENE_GROUND);
						right = (this.getSceneCell(i + 1, j) != Game.SCENE_GROUND);
						
						fallsNearby = int(up) + int(down) + int(left) + int(right);
						
						if (fallsNearby == 2)
						{
							if (up)
							{
								if (down)
								{
									var str:String = "";
									
									for (var iI:int = -5; iI < 6; iI++)
									{
										for (var iJ:int = -5; iJ < 6; iJ++)
										{
											str += this.getSceneCell(i + iI, j + iJ);
										}
										
										trace(str);
										str = "";
									}
									
									throw new Error();//TODO: don't throw
								}
								else if (left)
									this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_TL_DISK;
								else if (right)
									this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_TR_DISK;
							}
							else if (down)
							{
								if (left)
									this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_BL_DISK;
								else if (right)
									this.scene[i + j * Game.MAP_WIDTH] = Game.SCENE_BR_DISK;
							}
							else
								throw new Error();
						}
					}
					//TODO: replace some cells with the disk codes
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