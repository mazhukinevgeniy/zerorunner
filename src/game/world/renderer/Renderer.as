package game.world.renderer 
{
	import data.structs.GameConfig;
	import game.core.GameFoundations;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.world.clouds.Clouds;
	import game.world.IActors;
	import game.world.IScene;
	import game.world.items.utils.IPointCollector;
	import game.world.items.utils.ItemLogicBase;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Renderer 
	{
		private var scene:IScene;
		private var actors:IActors;
		
		private var points:IPointCollector;
		private var lines:Camera;
		
		private var pull:TilePull;
		
		private var xM:int;
		private var yM:int;
		
		public function Renderer(foundations:GameFoundations) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			this.points = foundations.pointsOfInterest;
			
			this.scene = foundations.scene;
			this.actors = foundations.actors;
			
			this.lines = new Camera(foundations);
			foundations.displayRoot.addChild(new Clouds(foundations));
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.numberedFrame);
			
			this.pull = new TilePull(foundations.atlas);
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
				this.redrawActors();
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
						else if (this.scene.getSceneCell(i, j) == Game.LAVA)
						{
							sprite = this.pull.getImage("lava");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
							
							
							if (this.scene.getSceneCell(i, j + 1) != Game.LAVA)
							{
								sprite = this.pull.getImage("bottom");
								
								sprite.x = i * Metric.CELL_WIDTH;
								sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height / 2;
								
								container.addImage(sprite);
							}
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
						}
					}
				}
				
			}
		}
		
		private function redrawActors():void
		{
			var center:ICoordinated = this.points.findPointOfInterest(Game.CHARACTER);
			
			const tlcX:int = center.x - 10;
			const tlcY:int = center.y - 8;
			
			const brcX:int = center.x + 11;
			const brcY:int = center.y + 9;
			
			var actor:ItemLogicBase;
			var container:DisplayObjectContainer = this.lines.actors;
			container.removeChildren();
			
			var i:int;
			var j:int;
			
			for (j = tlcY; j < brcY; j++)
			{				
				for (i = tlcX; i < brcX; i++)
				{
					actor = this.actors.findObjectByCell(i, j);
					
					if (actor)
					{
						container.addChild(actor.getView());
					}
				}
			}
		}
	}

}