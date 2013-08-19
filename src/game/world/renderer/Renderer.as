package game.world.renderer 
{
	import game.utils.GameFoundations;
	import game.utils.metric.Metric;
	import game.world.broods.ItemLogicBase;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Renderer 
	{
		private var data:SearcherFeature;
		private var lines:Camera;
		
		private var pull:TilePull;
		
		public function Renderer(data:SearcherFeature, foundations:GameFoundations) 
		{
			var flow:IUpdateDispatcher = foundations.flow;
			
			this.lines = new Camera(flow, foundations.juggler);
			
			this.data = data;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.redraw);
			
			this.pull = new TilePull(foundations.atlas);
		}
		
		update function redraw():void
		{
			this.redrawScene();
			this.redrawActors();
			this.redrawHazards();
		}
		
		private function redrawScene():void
		{
			const tlcX:int = this.data.cacheCenter.x - this.data.cacheWidth / 2;
			const tlcY:int = this.data.cacheCenter.y - this.data.cacheHeight / 2;
			
			const brcX:int = this.data.cacheCenter.x + this.data.cacheWidth / 2;
			const brcY:int = this.data.cacheCenter.y + this.data.cacheHeight / 2;
			
			var sprite:Image;
			
			const container:QuadBatch = this.lines.scene;
			container.reset();
			
			var i:int;
			var j:int;
			
			var number:uint;
			
			for (j = tlcY + 1; j < brcY - 1; j++)
			{ // main block
				for (i = tlcX + 1; i < brcX - 1; i++)
				{
					if (this.data.getUnsafeScene(i, j))
					{
						sprite = this.pull.getImage("ground");
						
						sprite.x = i * Metric.CELL_WIDTH;
						sprite.y = j * Metric.CELL_HEIGHT;
						
						container.addImage(sprite);
						
						number = uint(((i) * 999999000001) | ((j) * 87178291199));
						
						if (number % 13 < 3)
						{
							sprite = this.pull.getImage("stones" + (1 + number % 3));
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						
						if (!this.data.getUnsafeScene(i, j + 1))
						{
							sprite = this.pull.getImage("S");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (!this.data.getUnsafeScene(i + 1, j))
						{
							sprite = this.pull.getImage("E");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (!this.data.getUnsafeScene(i - 1, j))
						{
							sprite = this.pull.getImage("W");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (!this.data.getUnsafeScene(i, j - 1))
						{
							sprite = this.pull.getImage("N");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
						}
						if (!this.data.getUnsafeScene(i + 1, j + 1))
						{
							sprite = this.pull.getImage("SE");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (!this.data.getUnsafeScene(i - 1, j + 1))
						{
							sprite = this.pull.getImage("SW");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT;
							
							container.addImage(sprite);
						}
						if (!this.data.getUnsafeScene(i + 1, j - 1))
						{
							sprite = this.pull.getImage("NE");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
						}
						if (!this.data.getUnsafeScene(i - 1, j - 1))
						{
							sprite = this.pull.getImage("NW");
							
							sprite.x = i * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
							
							container.addImage(sprite);
						}
					}
				}
				
				//right line
				
				if (this.data.getUnsafeScene(i, j))
				{
					sprite = this.pull.getImage("ground");
					
					sprite.x = i * Metric.CELL_WIDTH;
					sprite.y = j * Metric.CELL_HEIGHT;
					
					container.addImage(sprite);
					
					number = uint(((i) * 999999000001) | ((j) * 87178291199));
					
					if (number % 13 < 3)
					{
						sprite = this.pull.getImage("stones" + (1 + number % 3));
						
						sprite.x = i * Metric.CELL_WIDTH;
						sprite.y = j * Metric.CELL_HEIGHT;
						
						container.addImage(sprite);
					}
					
					if (!this.data.getUnsafeScene(i, j + 1))
					{
						sprite = this.pull.getImage("S");
						
						sprite.x = i * Metric.CELL_WIDTH;
						sprite.y = (j + 1) * Metric.CELL_HEIGHT;
						
						container.addImage(sprite);
					}
					if (!this.data.getUnsafeScene(i - 1, j))
					{
						sprite = this.pull.getImage("W");
						
						sprite.x = i * Metric.CELL_WIDTH - sprite.width;
						sprite.y = j * Metric.CELL_HEIGHT;
						
						container.addImage(sprite);
					}
					if (!this.data.getUnsafeScene(i, j - 1))
					{
						sprite = this.pull.getImage("N");
						
						sprite.x = i * Metric.CELL_WIDTH;
						sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
						
						container.addImage(sprite);
					}
					if (!this.data.getUnsafeScene(i - 1, j + 1))
					{
						sprite = this.pull.getImage("SW");
						
						sprite.x = i * Metric.CELL_WIDTH - sprite.width;
						sprite.y = (j + 1) * Metric.CELL_HEIGHT;
						
						container.addImage(sprite);
					}
					if (!this.data.getUnsafeScene(i - 1, j - 1))
					{
						sprite = this.pull.getImage("NW");
						
						sprite.x = i * Metric.CELL_WIDTH - sprite.width;
						sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
						
						container.addImage(sprite);
					}
				}
			}
			
			for (i = tlcX + 1; i < brcX - 1; i++)
			{ //bottom line
				if (this.data.getUnsafeScene(i, j))
				{
					sprite = this.pull.getImage("ground");
					
					sprite.x = i * Metric.CELL_WIDTH;
					sprite.y = j * Metric.CELL_HEIGHT;
					
					container.addImage(sprite);
					
					number = uint(((i) * 999999000001) | ((j) * 87178291199));
					
					if (number % 13 < 3)
					{
						sprite = this.pull.getImage("stones" + (1 + number % 3));
						
						sprite.x = i * Metric.CELL_WIDTH;
						sprite.y = j * Metric.CELL_HEIGHT;
						
						container.addImage(sprite);
					}
					
					if (!this.data.getUnsafeScene(i + 1, j))
					{
						sprite = this.pull.getImage("E");
						
						sprite.x = (i + 1) * Metric.CELL_WIDTH;
						sprite.y = j * Metric.CELL_HEIGHT;
						
						container.addImage(sprite);
					}
					if (!this.data.getUnsafeScene(i - 1, j))
					{
						sprite = this.pull.getImage("W");
						
						sprite.x = i * Metric.CELL_WIDTH - sprite.width;
						sprite.y = j * Metric.CELL_HEIGHT;
						
						container.addImage(sprite);
					}
					if (!this.data.getUnsafeScene(i, j - 1))
					{
						sprite = this.pull.getImage("N");
						
						sprite.x = i * Metric.CELL_WIDTH;
						sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
						
						container.addImage(sprite);
					}
					if (!this.data.getUnsafeScene(i + 1, j - 1))
					{
						sprite = this.pull.getImage("NE");
						
						sprite.x = (i + 1) * Metric.CELL_WIDTH;
						sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
						
						container.addImage(sprite);
					}
					if (!this.data.getUnsafeScene(i - 1, j - 1))
					{
						sprite = this.pull.getImage("NW");
						
						sprite.x = i * Metric.CELL_WIDTH - sprite.width;
						sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
						
						container.addImage(sprite);
					}
				}
			}
			
			//bottom right corner
			if (this.data.getUnsafeScene(i, j))
			{
				sprite = this.pull.getImage("ground");
				
				sprite.x = i * Metric.CELL_WIDTH;
				sprite.y = j * Metric.CELL_HEIGHT;
				
				container.addImage(sprite);
				
				number = uint(((i) * 999999000001) | ((j) * 87178291199));
				
				if (number % 13 < 3)
				{
					sprite = this.pull.getImage("stones" + (1 + number % 3));
					
					sprite.x = i * Metric.CELL_WIDTH;
					sprite.y = j * Metric.CELL_HEIGHT;
					
					container.addImage(sprite);
				}
				
				if (!this.data.getUnsafeScene(i - 1, j))
				{
					sprite = this.pull.getImage("W");
					
					sprite.x = i * Metric.CELL_WIDTH - sprite.width;
					sprite.y = j * Metric.CELL_HEIGHT;
					
					container.addImage(sprite);
				}
				if (!this.data.getUnsafeScene(i, j - 1))
				{
					sprite = this.pull.getImage("N");
					
					sprite.x = i * Metric.CELL_WIDTH;
					sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
					
					container.addImage(sprite);
				}
				if (!this.data.getUnsafeScene(i - 1, j - 1))
				{
					sprite = this.pull.getImage("NW");
					
					sprite.x = i * Metric.CELL_WIDTH - sprite.width;
					sprite.y = j * Metric.CELL_HEIGHT - sprite.height;
					
					container.addImage(sprite);
				}
			}
		}
		
		private function redrawActors():void
		{
			const tlcX:int = this.data.cacheCenter.x - this.data.cacheWidth / 2;
			const tlcY:int = this.data.cacheCenter.y - this.data.cacheHeight / 2;
			
			const brcX:int = this.data.cacheCenter.x + this.data.cacheWidth / 2;
			const brcY:int = this.data.cacheCenter.y + this.data.cacheHeight / 2;
			
			var actor:ItemLogicBase;
			var container:DisplayObjectContainer = this.lines.actors;
			container.removeChildren();
			
			var i:int;
			var j:int;
			
			var number:uint;
			
			for (j = tlcY; j < brcY; j++)
			{				
				for (i = tlcX; i < brcX; i++)
				{
					actor = this.data.getUnsafeActor(i, j);
					
					if (actor)
					{
						container.addChild(actor.getView());
					}
				}
			}
		}
		
		private function redrawHazards():void
		{
			
		}
	}

}