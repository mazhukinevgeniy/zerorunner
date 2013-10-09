package game.world.renderer 
{
	import game.core.GameFoundations;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.world.ISearcher;
	import game.world.items.utils.IPointCollector;
	import game.world.items.utils.ItemLogicBase;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Renderer 
	{
		private var data:ISearcher;
		private var points:IPointCollector;
		private var lines:Camera;
		
		private var pull:TilePull;
		
		private var xM:int;
		private var yM:int;
		
		public function Renderer(data:ISearcher, points:IPointCollector, foundations:GameFoundations, clouds:DisplayObject) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			this.points = points;
			
			this.lines = new Camera(flow, foundations.juggler);
			this.lines.addChild(clouds);
			
			this.data = data;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.redraw);
			
			this.pull = new TilePull(foundations.atlas);
		}
		
		update function prerestore():void
		{
			this.xM = 1 + Math.random() * 5;
			this.yM = 1 + Math.random() * 5;
		}
		
		update function redraw():void
		{
			this.redrawScene();
			this.redrawActors();
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
					if (this.data.getSceneCell(i, j) == Game.ROAD)
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
						
						if (this.data.getSceneCell(i, j + 1) == Game.FALL)
						{
							sprite = this.pull.getImage("S");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.data.getSceneCell(i + 1, j) == Game.FALL)
						{
							sprite = this.pull.getImage("E");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.data.getSceneCell(i - 1, j) == Game.FALL)
						{
							sprite = this.pull.getImage("W");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.data.getSceneCell(i, j - 1) == Game.FALL)
						{
							sprite = this.pull.getImage("N");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
						}
						if (this.data.getSceneCell(i + 1, j + 1) == Game.FALL)
						{
							sprite = this.pull.getImage("SE");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.data.getSceneCell(i - 1, j + 1) == Game.FALL)
						{
							sprite = this.pull.getImage("SW");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (this.data.getSceneCell(i + 1, j - 1) == Game.FALL)
						{
							sprite = this.pull.getImage("NE");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
						}
						if (this.data.getSceneCell(i - 1, j - 1) == Game.FALL)
						{
							sprite = this.pull.getImage("NW");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
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
					actor = this.data.findObjectByCell(i, j);
					
					if (actor)
					{
						container.addChild(actor.getView());
					}
				}
			}
		}
	}

}