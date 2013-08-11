package game.world 
{
	import game.ZeroRunner;
	import starling.display.Image;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Renderer 
	{
		private var data:SearcherFeature;
		private var lines:Camera;
		
		private var pull:TilePull;
		
		public function Renderer(flow:IUpdateDispatcher, data:SearcherFeature, assets:AssetManager) 
		{
			this.lines = new Camera(flow);
			
			this.data = data;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(ZeroRunner.redraw);
			
			this.pull = new TilePull(assets);
		}
		
		update function quitGame():void
		{
			this.pull.nothingIsInUse();
		}
		
		update function redraw():void
		{
			this.lines.topLine = this.data.cacheCenter.y - this.data.cacheHeight / 2;
			
			this.pull.nothingIsInUse();
			
			this.redrawScene();
			this.redrawActors();
			this.redrawHazards();
		}
		
		private function redrawScene():void
		{
			/*
			var centerX:int = this.data.cacheCenter.x;
			var centerY:int = this.data.cacheCenter.y;
			
			var xGoal:int = centerX + this.data.sceneCacheWidth / 2;
			var yGoal:int = centerY + this.data.sceneCacheHeight / 2;
			
			var sprite:Image;
			
			for (var i:int = centerX - this.data.sceneCacheWidth / 2; i < xGoal; i++)
			{
				for (var j:int = centerY - this.data.sceneCacheHeight / 2; j < yGoal; j++)
				{
					if (this.getSceneCell(i, j))
					{
						sprite = this.pull.getImage("ground");
						
						sprite.x = i * Metric.CELL_WIDTH;
						sprite.y = j * Metric.CELL_HEIGHT;
						
						this.container.addChild(sprite);
						
						var number:uint = uint(((i) * 999999000001) | ((j) * 87178291199));
						
						if (number % 13 < 3)
						{
							sprite = this.pull.getImage("stones" + (1 + number % 3));
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
					}
					else
					{
						if (this.scene.getSceneCell(i, j - 1))
						{
							sprite = this.pull.getImage("S");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j))
						{
							sprite = this.pull.getImage("E");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j))
						{
							sprite = this.pull.getImage("W");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
						if (this.scene.getSceneCell(i, j + 1))
						{
							sprite = this.pull.getImage("N");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height;
							
							this.container.addChild(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j - 1) && 
							!this.scene.getSceneCell(i - 1, j) && 
							!this.scene.getSceneCell(i, j - 1))
						{
							sprite = this.pull.getImage("SE");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j - 1) && 
							!this.scene.getSceneCell(i + 1, j) && 
							!this.scene.getSceneCell(i, j - 1))
						{
							sprite = this.pull.getImage("SW");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
						if (this.scene.getSceneCell(i - 1, j + 1) && 
							!this.scene.getSceneCell(i - 1, j) && 
							!this.scene.getSceneCell(i, j + 1))
						{
							sprite = this.pull.getImage("NE");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height;
							
							this.container.addChild(sprite);
						}
						if (this.scene.getSceneCell(i + 1, j + 1) && 
							!this.scene.getSceneCell(i + 1, j) && 
							!this.scene.getSceneCell(i, j + 1))
						{
							sprite = this.pull.getImage("NW");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height;
							
							this.container.addChild(sprite);
						}
					}
				}
				
			}*/
		}
		
		private function redrawActors():void
		{
			
		}
		
		private function redrawHazards():void
		{
			
		}
	}

}