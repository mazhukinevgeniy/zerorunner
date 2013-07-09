package chaotic.scene 
{
	import chaotic.actors.storage.ISearcher;
	import chaotic.choosenArea.ChoosenArea;
	import chaotic.choosenArea.ISector;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.game.ChaoticGame;
	import chaotic.informers.IGiveInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.DPixelXY;
	import chaotic.metric.Metric;
	import chaotic.metric.PixelXY;
	import chaotic.ui.Camera;
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
		
		private var container:Sprite;
		
		public function LandscapeCanvas(flow:IUpdateDispatcher) 
		{
			this.container = new Sprite();
			this.container.touchable = false;
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ChaoticGame.prerestore);
			flow.addUpdateListener(ChaoticGame.tick);
			flow.addUpdateListener(ChaoticGame.getInformerFrom);
			
			flow.dispatchUpdate(Camera.addToTheLayer, Camera.SCENE, this.container);
		}
		
		public function tick():void
		{
			this.container.removeChildren();
			
			var center:CellXY = this.searcher.getCharacterCell();
			
			for (var i:int = 
		}
		
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.assets = table.getInformer(AssetManager);
			this.searcher = table.getInformer(ISearcher);
		}
		
		public function prerestore():void
		{
			if (this.pull == null) this.pull = new TilePull(this.assets);
		}
	}

}