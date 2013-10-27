package game.renderer 
{
	import data.viewers.GameConfig;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.points.IPointCollector;
	import game.scene.IScene;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import utils.updates.update;
	
	internal class SceneRenderer extends QuadBatch
	{
		private var pull:TilePull;
		
		private var xM:int;
		private var yM:int;
		
		private var points:IPointCollector;
		private var scene:IScene;
		
		public function SceneRenderer(elements:GameElements) 
		{
			super();
			
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			
			this.pull = new TilePull(elements.assets);
			
			
			this.points = elements.pointsOfInterest;
			this.scene = elements.scene;
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.xM = 1 + Math.random() * 5;
			this.yM = 1 + Math.random() * 5;
		}
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_REDRAW)
			{
				this.redraw();
			}
		}
		
		update function quitGame():void
		{
			this.reset();
		}
		
		private function redraw():void
		{
			this.reset(); 
			
			var center:ICoordinated = this.points.findPointOfInterest(Game.CHARACTER);
			
			const tlcX:int = center.x - 10;
			const tlcY:int = center.y - 8;
			
			const brcX:int = center.x + 11;
			const brcY:int = center.y + 9;
			
			var sprite:Image;
			
			var i:int;
			var j:int;
			
			var number:uint;
			
			for (j = tlcY; j < brcY; j++)
			{
				for (i = tlcX; i < brcX; i++)
				{
					if (this.scene.getSceneCell(i, j) != Game.FALL)
					{
						if (this.scene.getSceneCell(i, j + 1) == Game.FALL)
						{
							sprite = this.pull.getImage("ground_S");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j) == Game.FALL)
						{
							sprite = this.pull.getImage("ground_E");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j) == Game.FALL)
						{
							sprite = this.pull.getImage("ground_W");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i, j - 1) == Game.FALL)
						{
							sprite = this.pull.getImage("ground_N");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j + 1) == Game.FALL)
						{
							sprite = this.pull.getImage("ground_SE");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j + 1) == Game.FALL)
						{
							sprite = this.pull.getImage("ground_SW");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j - 1) == Game.FALL)
						{
							sprite = this.pull.getImage("ground_NE");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j - 1) == Game.FALL)
						{
							sprite = this.pull.getImage("ground_NW");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							this.addImage(sprite);
						}
						
						if (this.scene.getSceneCell(i, j) == Game.ROAD)
						{
							sprite = this.pull.getImage("ground");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.addImage(sprite);
							
							number = uint((i * this.xM * 999999000001) | (j * this.yM * 87178291199));
							
							if (number % 13 < 3)
							{
								sprite = this.pull.getImage("stones" + (1 + number % 3));
								
								sprite.x = i * Metric.CELL_WIDTH;
								sprite.y = j * Metric.CELL_HEIGHT;
								
								this.addImage(sprite);
							}
							
							
						}
					}
				}
				
			}
			
			for (j = tlcY; j < brcY; j++)
			{
				for (i = tlcX; i < brcX; i++)
				{
					if (this.scene.getSceneCell(i, j) == Game.LAVA)
					{
						sprite = this.pull.getImage("lava");
						
						sprite.x = i * Metric.CELL_WIDTH;
						sprite.y = j * Metric.CELL_HEIGHT;
						
						this.addImage(sprite);
						
						
						if (this.scene.getSceneCell(i + 1, j) != Game.LAVA)
						{
							sprite = this.pull.getImage("lava_E");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width / 2;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j) != Game.LAVA)
						{
							sprite = this.pull.getImage("lava_W");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width / 2;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i, j - 1) != Game.LAVA)
						{
							sprite = this.pull.getImage("lava_N");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height / 2;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i, j + 1) != Game.LAVA)
						{
							sprite = this.pull.getImage("lava_S");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height / 2;
							
							this.addImage(sprite);
						}
						
						
						if (this.scene.getSceneCell(i + 1, j + 1) != Game.LAVA &&
							this.scene.getSceneCell(i + 1, j) == Game.LAVA &&
							this.scene.getSceneCell(i, j + 1) == Game.LAVA)
						{
							sprite = this.pull.getImage("lava_SE");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j + 1) != Game.LAVA &&
							this.scene.getSceneCell(i - 1, j) == Game.LAVA &&
							this.scene.getSceneCell(i, j + 1) == Game.LAVA)
						{
							sprite = this.pull.getImage("lava_SW");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j - 1) != Game.LAVA &&
							this.scene.getSceneCell(i + 1, j) == Game.LAVA &&
							this.scene.getSceneCell(i, j - 1) == Game.LAVA)
						{
							sprite = this.pull.getImage("lava_NE");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j - 1) != Game.LAVA &&
							this.scene.getSceneCell(i - 1, j) == Game.LAVA &&
							this.scene.getSceneCell(i, j - 1) == Game.LAVA)
						{
							sprite = this.pull.getImage("lava_NW");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.addImage(sprite);
						}
					}
				}
			}
		}
	}

}