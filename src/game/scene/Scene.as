package game.scene 
{
	import game.actors.ActorsFeature;
	import game.actors.ISearcher;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.scene.patterns.FlatPattern;
	import game.scene.patterns.getPattern;
	import game.scene.patterns.IPattern;
	import game.time.ICacher;
	import game.time.Time;
	import game.ZeroRunner;
	import utils.informers.IGiveInformers;
	import utils.informers.IStoreInformers;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Scene implements ICacher, IScene
	{		
		private var patterns:Vector.<IPattern>;
		private var searcher:ISearcher;
		
		private var cacheVector:Vector.<int>;
		
		private const width:int = 2 * Metric.xDistanceSceneAllowed;
		private const height:int = 2 * Metric.yDistanceSceneAllowed;
		
		private var tLC:CellXY;
		
		private var nextY:DCellXY = new DCellXY(0, 1);
		private var nextColumn:DCellXY;
		private var unmodificate:DCellXY;
		
		private var toTLC:DCellXY;
		
		public function Scene(flow:IUpdateDispatcher) 
		{
			this.nextColumn = new DCellXY(1, -this.height);
			
			this.toTLC = new DCellXY( -Metric.xDistanceSceneAllowed, -Metric.yDistanceSceneAllowed);
			
			this.unmodificate = new DCellXY( -this.width, 0);
			
			this.cacheVector = new Vector.<int>(this.width * this.height, true);
			
			this.patterns = new Vector.<IPattern>(SceneFeature.NUMBER_OF_PATTERNS, true);
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.aftertick);
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			flow.dispatchUpdate(Time.addCacher, this);
		}
		
		public function getSceneCell(x:int, y:int):int
		{
			if ((!(x < this.tLC.x)) && (x < this.tLC.x + this.width)
				&&
			    (!(y < this.tLC.y)) && (y < this.tLC.y + this.height))
			{
				x -= this.tLC.x;
				y -= this.tLC.y;
				
				return this.cacheVector[x + y * this.width];
			}
			else return SceneFeature.FALL;
		}
		
		public function cache():void
		{
			var cell:CellXY = this.tLC;
			
			/**
			 * It's nice to enumerate from 0 to width-1, because it gives the easiest [i + j * width] access.
			 */
			for (var i:int = 0; i < this.width; i++)
			{
				for (var j:int = 0; j < this.height; j++)
				{
					this.cacheVector[i + j * this.width] = this.getCell(cell.x, cell.y);
					
					cell.applyChanges(this.nextY);
				}
				
				cell.applyChanges(this.nextColumn);
			}
			
			cell.applyChanges(this.unmodificate);
		}
		
		update function aftertick():void
		{
			this.searcher.getCharacterCell(this.tLC);
			this.tLC.applyChanges(this.toTLC);
		}
		
		private function getCell(x:int, y:int):int
		{
			if ((x + 10000) * (x + 10000) + (y + 10000) * (y + 10000) < 6 * 6)
				return SceneFeature.ROAD;
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
			
			this.tLC = ActorsFeature.SPAWN_CELL.applyChanges(this.toTLC);
			
			this.cache();
		}
		
		update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IScene, this);
		}
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			this.searcher = table.getInformer(ISearcher);
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