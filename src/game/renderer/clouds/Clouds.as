package game.renderer.clouds 
{
	import data.viewers.GameConfig;
	import game.core.metric.DCellXY;
	import game.GameElements;
	import starling.extensions.krecha.ScrollImage;
	import starling.extensions.krecha.ScrollTile;
	import utils.PixelPerfectTween;
	import utils.updates.update;
	
	public class Clouds extends ScrollImage
	{
		internal static const SIZE_CLOUDINNESS_SCALE:int = 10;
		
		private var elements:GameElements;
		
		private var moveTween:PixelPerfectTween;
		
		public function Clouds(elements:GameElements) 
		{
			this.elements = elements;
			
			this.moveTween = new PixelPerfectTween(this, 0);
			
			super(Main.WIDTH, Main.HEIGHT, false);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
			elements.flow.addUpdateListener(Update.moveCenter);
			elements.flow.addUpdateListener(Update.quitGame);
		}
		
		update function prerestore(config:GameConfig):void
		{
			const numberOfClouds:int = 4;
			var cloudiness:int = config.cloudiness % Clouds.SIZE_CLOUDINNESS_SCALE;
			
			var cloudAtlas:CloudAtlas = new CloudAtlas(cloudiness);
			var tile:ScrollTile;
			
			for (var i:int = 0; i < numberOfClouds; i++)
			{
				tile = this.addLayer(new Cloud(cloudAtlas.getTexture("texture" + String(i + 1))));
				
				tile.offsetX = Math.random() * 100;
				tile.offsetY = Math.random() * 100;
				
				tile.alpha = 1/4;//TODO remove
			}
			
			this.x = this.y = 0;
		}
		
		update function moveCenter(change:DCellXY, ticksToGo:int):void 
		{
			this.moveTween.reset(this, ticksToGo * Game.TIME_BETWEEN_TICKS);
			
			this.moveTween.animate("tilesOffsetX", this.tilesOffsetX - Game.CELL_WIDTH * change.x);
			this.moveTween.animate("tilesOffsetY", this.tilesOffsetY - Game.CELL_HEIGHT * change.y);
			
			this.elements.juggler.add(this.moveTween);
		}
		
		update function quitGame():void
		{
			for (var i:int = 0; i < this.numLayers; i++)
			{
				var cloud:Cloud = this.getLayerAt(i) as Cloud;
				
				cloud.die();
			}
			
			this.moveTween.reset(this, 0);
			
			
			const dispose:Boolean = true;
			
			this.removeAll(dispose);
		}
	}

}