package game.renderer 
{
	import data.viewers.GameConfig;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.items.base.ItemBase;
	import game.items.Items;
	import game.points.IPointCollector;
	import game.scene.IScene;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Renderer 
	{
		private var scene:IScene;
		private var items:Items;
		
		private var points:IPointCollector;
		private var lines:Camera;
		
		private var pull:TilePull;
		
		private var xM:int;
		private var yM:int;
		
		public function Renderer(elements:GameElements) 
		{
			var flow:IUpdateDispatcher = elements.flow;
			this.points = elements.pointsOfInterest;
			
			this.scene = elements.scene;
			this.items = elements.items;
			
			this.lines = new Camera(elements);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.numberedFrame);
			
			this.pull = new TilePull(elements.atlas);
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
				this.redrawScene();
				this.redrawItems();
			}
		}
		
		private function redrawScene():void
		{
			var center:ICoordinated = this.points.findPointOfInterest(Game.CHARACTER);
			
			const tlcX:int = center.x - 10;
			const tlcY:int = center.y - 8;
			
			const brcX:int = center.x + 11;
			const brcY:int = center.y + 9;
			
			var sprite:Image;
			
			const container:QuadBatch = this.lines.scene;
			container.reset();
			
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
							sprite = this.pull.getImage("S");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j) == Game.FALL)
						{
							sprite = this.pull.getImage("E");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j) == Game.FALL)
						{
							sprite = this.pull.getImage("W");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i, j - 1) == Game.FALL)
						{
							sprite = this.pull.getImage("N");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j + 1) == Game.FALL)
						{
							sprite = this.pull.getImage("SE");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j + 1) == Game.FALL)
						{
							sprite = this.pull.getImage("SW");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j - 1) == Game.FALL)
						{
							sprite = this.pull.getImage("NE");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j - 1) == Game.FALL)
						{
							sprite = this.pull.getImage("NW");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
						}
						
						if (this.scene.getSceneCell(i, j) == Game.ROAD)
						{
							sprite = this.pull.getImage("ground");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
							
							number = uint((i * this.xM * 999999000001) | (j * this.yM * 87178291199));
							
							if (number % 13 < 3)
							{
								sprite = this.pull.getImage("stones" + (1 + number % 3));
								
								sprite.x = i * Metric.CELL_WIDTH;
								sprite.y = j * Metric.CELL_HEIGHT;
								
								container.addImage(sprite);
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
						
						container.addImage(sprite);
						
						
						if (this.scene.getSceneCell(i + 1, j) != Game.LAVA)
						{
							sprite = this.pull.getImage("right");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width / 2;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j) != Game.LAVA)
						{
							sprite = this.pull.getImage("left");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width / 2;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i, j - 1) != Game.LAVA)
						{
							sprite = this.pull.getImage("top");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height / 2;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i, j + 1) != Game.LAVA)
						{
							sprite = this.pull.getImage("bottom");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height / 2;
							
							container.addImage(sprite);
						}
						
						
						if (this.scene.getSceneCell(i + 1, j + 1) != Game.LAVA &&
							this.scene.getSceneCell(i + 1, j) == Game.LAVA &&
							this.scene.getSceneCell(i, j + 1) == Game.LAVA)
						{
							sprite = this.pull.getImage("3");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j + 1) != Game.LAVA &&
							this.scene.getSceneCell(i - 1, j) == Game.LAVA &&
							this.scene.getSceneCell(i, j + 1) == Game.LAVA)
						{
							sprite = this.pull.getImage("1");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j - 1) != Game.LAVA &&
							this.scene.getSceneCell(i + 1, j) == Game.LAVA &&
							this.scene.getSceneCell(i, j - 1) == Game.LAVA)
						{
							sprite = this.pull.getImage("9");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j - 1) != Game.LAVA &&
							this.scene.getSceneCell(i - 1, j) == Game.LAVA &&
							this.scene.getSceneCell(i, j - 1) == Game.LAVA)
						{
							sprite = this.pull.getImage("7");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
					}
				}
			}
		}
		
		private function redrawItems():void
		{
			var center:ICoordinated = this.points.findPointOfInterest(Game.CHARACTER);
			
			const tlcX:int = center.x - 10;
			const tlcY:int = center.y - 8;
			
			const brcX:int = center.x + 11;
			const brcY:int = center.y + 9;
			
			var item:ItemBase;
			var container:DisplayObjectContainer = this.lines.items;
			container.removeChildren();
			
			var i:int;
			var j:int;
			
			for (j = tlcY; j < brcY; j++)
			{				
				for (i = tlcX; i < brcX; i++)
				{
					item = this.items.findObjectByCell(i, j);
					
					if (item)
					{
						container.addChild(item.getView());
					}
				}
			}
		}
	}

}