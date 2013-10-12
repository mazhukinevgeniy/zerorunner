package game.world.clouds 
{
	import game.core.GameFoundations;
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
		private var foundations:GameFoundations;
		
		private var moveTween:PixelPerfectTween;
		
		public function Clouds(foundations:GameFoundations) 
		{
			this.foundations = foundations;
			
			this.moveTween = new PixelPerfectTween(this, 0);
			
			super(Main.WIDTH * 1.3, Main.HEIGHT * 1.3, false);
			
			foundations.flow.workWithUpdateListener(this);
			foundations.flow.addUpdateListener(Update.prerestore);
			foundations.flow.addUpdateListener(Update.moveCenter);
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