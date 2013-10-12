package game.world.clouds 
{
	import game.core.GameFoundations;
	import starling.display.Sprite;
	import starling.extensions.krecha.ScrollImage;
	import starling.extensions.krecha.ScrollTile;
	import utils.updates.update;
	
	public class Clouds extends ScrollImage
	{
		private var foundations:GameFoundations;
		
		public function Clouds(foundations:GameFoundations) 
		{
			this.foundations = foundations;
			
			super(Main.WIDTH * 1.3, Main.HEIGHT * 1.3, false);
			
			foundations.flow.workWithUpdateListener(this);
			foundations.flow.addUpdateListener(Update.prerestore);
			foundations.flow.addUpdateListener(Update.quitGame);
		}
		
		update function prerestore():void
		{
			const numberOfClouds:int = 2 + Math.random() * 2;
			
			var tile:ScrollTile;
			
			for (var i:int = 0; i < numberOfClouds; i++)
			{
				tile = this.addLayer(new Cloud(this.foundations));
				
				tile.alpha = 0.2 + Math.random() * 0.6;
				
				tile.scaleX = tile.scaleY = Math.random() * 3;
				
				tile.offsetX = Math.random() * 100;
				tile.offsetY = Math.random() * 100;
			}
			
			this.pivotX = 0;//Main.WIDTH / 2;
			this.pivotY = 0;// Main.HEIGHT / 2;
			//TODO: learn how exactly it works
		}
		
		update function quitGame():void
		{
			for (var i:int = 0; i < this.numLayers; i++)
			{
				var cloud:Cloud = this.getLayerAt(i) as Cloud;
				
				cloud.die();
			}
			
			
			
			const dispose:Boolean = true;
			
			this.removeAll(dispose);
		}
	}

}