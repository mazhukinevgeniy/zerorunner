package game.scene 
{
	import game.metric.ICoordinated;
	import game.scene.patterns.FlatPattern;
	import game.scene.patterns.getPattern;
	import game.scene.patterns.IPattern;
	import game.ZeroRunner;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Scene
	{		
		private var patterns:Vector.<IPattern>;
		
		public function Scene(flow:IUpdateDispatcher)
		{
			this.patterns = new Vector.<IPattern>(SceneFeature.NUMBER_OF_PATTERNS, true);
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
		}
		
		update function cacheScene(cache:Vector.<int>, center:ICoordinated, width:int, height:int):void
		{			
			var tlcX:int = center.x - width / 2;
			var tlcY:int = center.y - height / 2;
			
			for (var i:int = 0; i < width; i++)
				for (var j:int = 0; j < height; j++)
				{
					cache[i + j * width] = this.getCell(i + tlcX, j + tlcY);
				}
		}
		
		private function getCell(x:int, y:int):int
		{
			return this.patterns[uint((x * 84673) ^ (y * 108301)) % SceneFeature.NUMBER_OF_PATTERNS].getNumber(x, y);
		}
		
		update function prerestore():void
		{
			var specN1:int = Math.random() * SceneFeature.NUMBER_OF_PATTERNS;
			var specN2:int = specN1;
			while (specN1 == specN2)
				specN2 = Math.random() * SceneFeature.NUMBER_OF_PATTERNS;
			
			for (var i:int = 0; i < SceneFeature.NUMBER_OF_PATTERNS; i++)
			{
				if (i == specN1 || i == specN2)
					this.patterns[i] = new FlatPattern();
				else
					this.patterns[i] = getPattern();
			}
		}
		
		/*
		 * 
		
		update function tick():void
		{
			this.container.removeChildren();
			this.pull.nothingIsInUse();
			
			var centerX:int = this.searcher.character.x;
			var centerY:int = this.searcher.character.y;
			
			var xGoal:int = centerX + this.width;
			var yGoal:int = centerY + this.height;
			
			var sprite:Image;
			
			for (var i:int = centerX - this.width; i < xGoal; i++)
			{
				for (var j:int = centerY - this.height; j < yGoal; j++)
				{
					if (this.scene.getSceneCell(i, j))
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
				
			}
		}
		
		update function quitGame():void
		{
			this.container.removeChildren();
			this.pull.nothingIsInUse();
		}
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			this.assets = table.getInformer(AssetManager);
			this.searcher = table.getInformer(ISearcher);
			this.scene = table.getInformer(IScene);
		}
		
		update function prerestore():void
		{
			if (this.pull == null) this.pull = new TilePull(this.assets);
		}
		
		 * 
		 * 
		 */
	}

}