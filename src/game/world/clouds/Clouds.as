package game.world.clouds 
{
	import data.viewers.GameConfig;
	import game.core.GameElements;
	import game.core.metric.DCellXY;
	import game.core.metric.Metric;
	import game.core.time.Time;
	import starling.display.Sprite;
	import starling.extensions.krecha.ScrollImage;
	import starling.extensions.krecha.ScrollTile;
	import utils.PixelPerfectTween;
	import utils.updates.update;
	
	public class Clouds extends ScrollImage
	{
		private var foundations:GameElements;
		
		private var moveTween:PixelPerfectTween;
		
		public function Clouds(foundations:GameElements) 
		{
			this.foundations = foundations;
			
			this.moveTween = new PixelPerfectTween(this, 0);
			
			super(Main.WIDTH, Main.HEIGHT, false);
			
			foundations.flow.workWithUpdateListener(this);
			foundations.flow.addUpdateListener(Update.prerestore);
			foundations.flow.addUpdateListener(Update.moveCenter);
			foundations.flow.addUpdateListener(Update.quitGame);
		}
		
		update function prerestore(config:GameConfig):void
		{
			const numberOfClouds:int = 2 + Math.random() * 2;
			//TODO: link to config as cloud density is important
			
			var tile:ScrollTile;
			
			for (var i:int = 0; i < numberOfClouds; i++)
			{
				tile = this.addLayer(new Cloud(this.foundations));
				
				tile.alpha = 0; //TODO: enable again when suitable
				
				tile.offsetX = Math.random() * 100;
				tile.offsetY = Math.random() * 100;
			}
			
			this.x = this.y = 0;
		}
		
		update function moveCenter(change:DCellXY, ticksToGo:int):void 
		{
			this.moveTween.reset(this, ticksToGo * Time.TIME_BETWEEN_TICKS);
			
			this.moveTween.animate("tilesOffsetX", this.tilesOffsetX - Metric.CELL_WIDTH * change.x);
			this.moveTween.animate("tilesOffsetY", this.tilesOffsetY - Metric.CELL_HEIGHT * change.y);
			
			this.foundations.juggler.add(this.moveTween);
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