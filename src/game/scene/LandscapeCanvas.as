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
	import game.ui.Camera;
	import game.ZeroRunner;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	internal class LandscapeCanvas
	{
		private var pull:TilePull;
		private var assets:AssetManager;
		
		private var searcher:ISearcher;
		private var scene:IScene;
		
		private var container:Sprite;
		
		private var width:int = 1 + (Metric.CELLS_IN_VISIBLE_WIDTH + 2) / 2;
		private var height:int = 1 + (Metric.CELLS_IN_VISIBLE_HEIGHT + 2) / 2;
		
		
		public function LandscapeCanvas(flow:IUpdateDispatcher) 
		{
			this.container = new Sprite();
			this.container.touchable = false;
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.tick);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			
			flow.dispatchUpdate(Camera.addToTheLayer, Camera.SCENE, this.container);
		}
		
		public function tick():void
		{
			this.container.removeChildren();
			this.pull.nothingIsInUse();
			
			var center:CellXY = this.searcher.getCharacterCell();
			
			var xGoal:int = center.x + this.width;
			var yGoal:int = center.y + this.height;
			
			for (var i:int = center.x - 2 * this.width; i < xGoal; i++)
			{
				for (var j:int = center.y - 2 * this.height; j < yGoal; j++)
				{
					var sprite:Image = this.pull.getImage(this.getCode(new CellXY(i, j)));
					
					sprite.x = i * Metric.CELL_WIDTH;
					sprite.y = j * Metric.CELL_HEIGHT;
					
					this.container.addChild(sprite);
				}
				
			}
		}
		
		private function getCode(cell:CellXY):int
		{
			return this.scene.getSceneCell(cell);
		}
		
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.assets = table.getInformer(AssetManager);
			this.searcher = table.getInformer(ISearcher);
			
			this.scene = table.getInformer(IScene);
		}
		
		public function prerestore():void
		{
			if (this.pull == null) this.pull = new TilePull(this.assets);
		}
	}

}