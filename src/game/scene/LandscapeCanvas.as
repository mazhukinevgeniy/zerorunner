package game.scene 
{
	import game.actors.storage.ISearcher;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.DPixelXY;
	import game.metric.Metric;
	import game.metric.PixelXY;
	import game.time.Time;
	import game.ui.Camera;
	import game.ZeroRunner;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	internal class LandscapeCanvas
	{
		private var pull:TilePull;
		private var assets:AssetManager;
		
		private var searcher:ISearcher;
		private var cache:LandscapeCache;
		
		private var container:Sprite;
		
		private const width:int = 1 + (Metric.CELLS_IN_VISIBLE_WIDTH + 2) / 2;
		private const height:int = 1 + (Metric.CELLS_IN_VISIBLE_HEIGHT + 2) / 2;
		
		
		public function LandscapeCanvas(flow:IUpdateDispatcher, cache:LandscapeCache) 
		{
			this.container = new Sprite();
			
			this.container.touchable = false;
			
			this.cache = cache;
			
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.tick);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			flow.dispatchUpdate(Camera.addToTheLayer, Camera.SCENE, this.container);
			
			for (var i:int = 0; i < 6; i++)
				flow.dispatchUpdate(Time.addCacher, cache);
		}
		
		public function tick():void
		{
			this.container.removeChildren();
			this.pull.nothingIsInUse();
			
			var center:CellXY = this.searcher.getCharacterCell();
			
			var xGoal:int = center.x + this.width;
			var yGoal:int = center.y + this.height;
			
			var sprite:Image;
			
			for (var i:int = center.x - this.width; i < xGoal; i++)
			{
				for (var j:int = center.y - this.height; j < yGoal; j++)
				{
					if (this.cache.getCached(i, j))
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
						if (this.cache.getCached(i, j - 1))
						{
							sprite = this.pull.getImage("S");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
						if (this.cache.getCached(i - 1, j))
						{
							sprite = this.pull.getImage("E");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
						if (this.cache.getCached(i + 1, j))
						{
							sprite = this.pull.getImage("W");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
						if (this.cache.getCached(i, j + 1))
						{
							sprite = this.pull.getImage("N");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height;
							
							this.container.addChild(sprite);
						}
						if (this.cache.getCached(i - 1, j - 1) && 
							!this.cache.getCached(i - 1, j) && 
							!this.cache.getCached(i, j - 1))
						{
							sprite = this.pull.getImage("SE");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
						if (this.cache.getCached(i + 1, j - 1) && 
							!this.cache.getCached(i + 1, j) && 
							!this.cache.getCached(i, j - 1))
						{
							sprite = this.pull.getImage("SW");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width;
							sprite.y = j * Metric.CELL_HEIGHT;
							
							this.container.addChild(sprite);
						}
						if (this.cache.getCached(i - 1, j + 1) && 
							!this.cache.getCached(i - 1, j) && 
							!this.cache.getCached(i, j + 1))
						{
							sprite = this.pull.getImage("NE");
							
							sprite.x = i * Metric.CELL_WIDTH;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height;
							
							this.container.addChild(sprite);
						}
						if (this.cache.getCached(i + 1, j + 1) && 
							!this.cache.getCached(i + 1, j) && 
							!this.cache.getCached(i, j + 1))
						{
							sprite = this.pull.getImage("NW");
							
							sprite.x = (i + 1) * Metric.CELL_WIDTH - sprite.width;
							sprite.y = (j + 1) * Metric.CELL_HEIGHT - sprite.height;
							
							this.container.addChild(sprite);
						}
					}
				}
				
			}
			
			this.cache.setTopLeftCell(new CellXY(center.x - this.width, center.y - this.height));
		}
		
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.assets = table.getInformer(AssetManager);
			this.searcher = table.getInformer(ISearcher);
		}
		
		public function prerestore():void
		{
			if (this.pull == null) this.pull = new TilePull(this.assets);
			
			this.cache.setTopLeftCell(new CellXY(40 - 10, 40 - 10));
		}
	}

}