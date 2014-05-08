package view.game.renderer.clouds 
{
	import binding.IBinder;
	import controller.observers.game.INewGameHandler;
	import controller.observers.game.IQuitGameHandler;
	import starling.display.DisplayObject;
	import starling.extensions.krecha.ScrollImage;
	import starling.extensions.krecha.ScrollTile;
	import view.game.renderer.IRenderer;
	
	public class Clouds extends ScrollImage implements IRenderer, INewGameHandler, IQuitGameHandler
	{
		internal static const CLOUDINESS:int = 2;
		
		private var usedAtlas:CloudAtlas;
		
		private var leader:DisplayObject;
		
		public function Clouds(binder:IBinder, leader:DisplayObject) 
		{
			this.leader = leader;
			
			binder.notifier.addGameStatusObserver(this);
			
			super(Main.WIDTH, Main.HEIGHT, false);
		}
		
		public function newGame():void
		{
			const numberOfClouds:int = 4;
			var cloudiness:int = Clouds.CLOUDINESS;
			
			
			
			if (this.usedAtlas)
			{
				throw new Error("something is broken, please check Clouds.as");
			}
			
			var cloudAtlas:CloudAtlas = this.usedAtlas = new CloudAtlas(cloudiness);
			var tile:ScrollTile;
			
			for (var i:int = 0; i < numberOfClouds; i++)
			{
				tile = this.addLayer(new Cloud(cloudAtlas.getTexture("texture" + String(i + 1))));
				
				tile.offsetX = Math.random() * 100;
				tile.offsetY = Math.random() * 100;
				
				tile.alpha = 1/4;
			}
			
			this.x = this.y = 0;
		}
		
		public function redraw():void 
		{
			this.tilesOffsetX = this.leader.x;
            this.tilesOffsetY = this.leader.y;
			
			
			for (var i:int = 0; i < this.numLayers; i++)
			{
				var cloud:Cloud = this.getLayerAt(i) as Cloud;
				
				
				cloud.offsetX = int(cloud.offsetX + cloud.dX);
				cloud.offsetY = int(cloud.offsetY + cloud.dY);
			}
		}
		
		public function quitGame():void
		{
			const dispose:Boolean = true;
			
			this.usedAtlas.dispose();
			this.usedAtlas = null;
			
			this.removeAll(dispose);
		}
	}

}