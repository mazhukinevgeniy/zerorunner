package game.scene 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.time.Time;
	import game.ZeroRunner;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.informers.IGiveInformers;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class LandscapeCanvas
	{
		private var pull:TilePull;
		private var assets:AssetManager;
		
		private var searcher:ISearcher;
		private var scene:IScene;
		
		private var container:Sprite;
		
		private const width:int = 1 + (Metric.CELLS_IN_VISIBLE_WIDTH + 2) / 2;
		private const height:int = 1 + (Metric.CELLS_IN_VISIBLE_HEIGHT + 2) / 2;
		
		
		public function LandscapeCanvas(flow:IUpdateDispatcher) 
		{
			this.container = new Sprite();
			
			this.container.touchable = false;
			
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.tick);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			flow.addUpdateListener(ZeroRunner.quitGame);
			
			flow.dispatchUpdate(Camera.addToTheLayer, Camera.SCENE, this.container);
		}
		
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
	}

}