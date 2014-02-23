package game.renderer 
{
	import game.GameElements;
	import game.metric.CellXY;
	import game.metric.ICoordinated;
	import game.scene.IScene;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.textures.TextureAtlas;
	import utils.updates.update;
	
	internal class SceneRenderer extends QuadBatch
	{
		private var ground:Image;
		private var ground_S:Image, ground_W:Image, ground_E:Image, ground_N:Image;
		private var ground_NE:Image, ground_NW:Image, ground_SE:Image, ground_SW:Image;
		private var stones1:Image, stones2:Image, stones3:Image;
		private var solidGround:Image;
		private var lava:Image;
		private var lava_S:Image, lava_W:Image, lava_E:Image, lava_N:Image;
		private var lava_NE:Image, lava_NW:Image, lava_SE:Image, lava_SW:Image;
		
		private var xM:int = 1 + Math.random() * 5;
		private var yM:int = 1 + Math.random() * 5;
		
		private var scene:IScene;
		
		private var center:ICoordinated;
		private var previousCenter:CellXY;
		
		public function SceneRenderer(elements:GameElements) 
		{
			super();
			
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			
			this.scene = elements.scene;
			
			
			var atlas:TextureAtlas = elements.assets.getTextureAtlas("sprites");
			
			for each (var key:String in 
					["ground", "ground_S", "ground_W", "ground_E", "ground_N",
					 "ground_NE", "ground_NW", "ground_SE", "ground_SW",
					 "stones1", "stones2", "stones3",
					 "solidGround",
					 "lava",
					 "lava_S", "lava_W", "lava_E", "lava_N",
					 "lava_NE", "lava_NW", "lava_SE", "lava_SW"])
				this[key] = new Image(atlas.getTexture(key));
			
			
			this.previousCenter = new CellXY(-1, -1);
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.xM = 1 + Math.random() * 5;
			this.yM = 1 + Math.random() * 5;
			
			this.previousCenter.setValue( -1, -1);
			
			this.center = center;
		}
		
		update function numberedFrame(key:int):void
		{
			if (!this.previousCenter.isEqualTo(this.center))
			{
				this.redraw();
				
				this.previousCenter.setValue(this.center.x, this.center.y);
			}
		}
		
		update function quitGame():void
		{
			this.reset();
		}
		
		private function redraw():void
		{
			this.reset();
			
			const tlcX:int = this.center.x - 10;
			const tlcY:int = this.center.y - 8;
			
			const brcX:int = this.center.x + 11;
			const brcY:int = this.center.y + 9;
			
			var sprite:Image;
			
			var i:int;
			var j:int;
			
			var number:uint;
			
			for (j = tlcY; j < brcY; j++)
			{
				for (i = tlcX; i < brcX; i++)
				{
					if (this.scene.getSceneCell(i, j) != Game.SCENE_FALL)
					{
						if (this.scene.getSceneCell(i, j + 1) == Game.SCENE_FALL)
						{
							sprite = this.ground_S;
							
							sprite.x = i * Game.CELL_WIDTH;
							sprite.y = (j + 1) * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j) == Game.SCENE_FALL)
						{
							sprite = this.ground_E;
							
							sprite.x = (i + 1) * Game.CELL_WIDTH;
							sprite.y = j * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j) == Game.SCENE_FALL)
						{
							sprite = this.ground_W;
							
							sprite.x = i * Game.CELL_WIDTH - sprite.width;
							sprite.y = j * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i, j - 1) == Game.SCENE_FALL)
						{
							sprite = this.ground_N;
							
							sprite.x = i * Game.CELL_WIDTH;
							sprite.y = j * Game.CELL_HEIGHT - sprite.height;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j + 1) == Game.SCENE_FALL)
						{
							sprite = this.ground_SE;
							
							sprite.x = (i + 1) * Game.CELL_WIDTH;
							sprite.y = (j + 1) * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j + 1) == Game.SCENE_FALL)
						{
							sprite = this.ground_SW;
							
							sprite.x = i * Game.CELL_WIDTH - sprite.width;
							sprite.y = (j + 1) * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j - 1) == Game.SCENE_FALL)
						{
							sprite = this.ground_NE;
							
							sprite.x = (i + 1) * Game.CELL_WIDTH;
							sprite.y = j * Game.CELL_HEIGHT - sprite.height;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j - 1) == Game.SCENE_FALL)
						{
							sprite = this.ground_NW;
							
							sprite.x = i * Game.CELL_WIDTH - sprite.width;
							sprite.y = j * Game.CELL_HEIGHT - sprite.height;
							
							this.addImage(sprite);
						}
						
						if (this.scene.getSceneCell(i, j) == Game.SCENE_GROUND)
						{
							sprite = this.ground;
							
							sprite.x = i * Game.CELL_WIDTH;
							sprite.y = j * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
							
							number = 
								uint(
									 (normalize(i) * this.xM * 999999000001) 
									|
									 (normalize(j) * this.yM * 87178291199)
									);
							
							if (number % 13 < 3)
							{
								sprite = this["stones" + (1 + number % 3)];
								
								sprite.x = i * Game.CELL_WIDTH;
								sprite.y = j * Game.CELL_HEIGHT;
								
								this.addImage(sprite);
							}
							
							
						}
						else if (this.scene.getSceneCell(i, j) == Game.SCENE_SOLID_GROUND)
						{//TODO: don't get i,j so often
						 //TODO: what if we have our own cache? seems semilegit
							
							sprite = this.solidGround;
							
							sprite.x = i * Game.CELL_WIDTH;
							sprite.y = j * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
					}
				}
				
			}
			
			for (j = tlcY; j < brcY; j++)
			{
				for (i = tlcX; i < brcX; i++)
				{
					if (this.scene.getSceneCell(i, j) == Game.SCENE_LAVA)
					{
						sprite = this.lava;
						
						sprite.x = i * Game.CELL_WIDTH;
						sprite.y = j * Game.CELL_HEIGHT;
						
						this.addImage(sprite);
						
						
						if (this.scene.getSceneCell(i + 1, j) != Game.SCENE_LAVA)
						{
							sprite = this.lava_E;
							
							sprite.x = (i + 1) * Game.CELL_WIDTH - sprite.width / 2;
							sprite.y = j * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j) != Game.SCENE_LAVA)
						{
							sprite = this.lava_W;
							
							sprite.x = i * Game.CELL_WIDTH - sprite.width / 2;
							sprite.y = j * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i, j - 1) != Game.SCENE_LAVA)
						{
							sprite = this.lava_N;
							
							sprite.x = i * Game.CELL_WIDTH;
							sprite.y = j * Game.CELL_HEIGHT - sprite.height / 2;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i, j + 1) != Game.SCENE_LAVA)
						{
							sprite = this.lava_S;
							
							sprite.x = i * Game.CELL_WIDTH;
							sprite.y = (j + 1) * Game.CELL_HEIGHT - sprite.height / 2;
							
							this.addImage(sprite);
						}
						
						
						if (this.scene.getSceneCell(i + 1, j + 1) != Game.SCENE_LAVA &&
							this.scene.getSceneCell(i + 1, j) == Game.SCENE_LAVA &&
							this.scene.getSceneCell(i, j + 1) == Game.SCENE_LAVA)
						{
							sprite = this.lava_SE;
							
							sprite.x = (i + 1) * Game.CELL_WIDTH - sprite.width;
							sprite.y = (j + 1) * Game.CELL_HEIGHT - sprite.height;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j + 1) != Game.SCENE_LAVA &&
							this.scene.getSceneCell(i - 1, j) == Game.SCENE_LAVA &&
							this.scene.getSceneCell(i, j + 1) == Game.SCENE_LAVA)
						{
							sprite = this.lava_SW;
							
							sprite.x = i * Game.CELL_WIDTH;
							sprite.y = (j + 1) * Game.CELL_HEIGHT - sprite.height;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j - 1) != Game.SCENE_LAVA &&
							this.scene.getSceneCell(i + 1, j) == Game.SCENE_LAVA &&
							this.scene.getSceneCell(i, j - 1) == Game.SCENE_LAVA)
						{
							sprite = this.lava_NE;
							
							sprite.x = (i + 1) * Game.CELL_WIDTH - sprite.width;
							sprite.y = j * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j - 1) != Game.SCENE_LAVA &&
							this.scene.getSceneCell(i - 1, j) == Game.SCENE_LAVA &&
							this.scene.getSceneCell(i, j - 1) == Game.SCENE_LAVA)
						{
							sprite = this.lava_NW;
							
							sprite.x = i * Game.CELL_WIDTH;
							sprite.y = j * Game.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
					}
				}
			}
		}
		
		
		//TODO: the code above must be shrinkable (plus Quadr works on it); ergo, shrink it
		
	}

}