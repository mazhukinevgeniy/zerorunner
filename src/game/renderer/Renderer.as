package game.renderer 
{
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.core.time.Time;
	import game.GameElements;
	import starling.animation.Juggler;
	import starling.display.Sprite;
	import utils.PixelPerfectTween;
	import utils.updates.update;
	
	public class Renderer extends Sprite
	{
		private var moveTween:PixelPerfectTween;
		
		private var juggler:Juggler;
		
		public function Renderer(elements:GameElements) 
		{
			super();
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.setCenter);
			elements.flow.addUpdateListener(Update.moveCenter);
			elements.displayRoot.addChild(this);
			
			this.moveTween = new PixelPerfectTween(this, 0);
			
			
			this.juggler = elements.juggler;
			this.addChild(new SceneRenderer(elements));
			this.addChild(new ItemRenderer(elements));
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.x = -center.x * Metric.CELL_WIDTH + (Main.WIDTH - Metric.CELL_WIDTH) / 2;
            this.y = -center.y * Metric.CELL_HEIGHT + (Main.HEIGHT - Metric.CELL_HEIGHT) / 2;
			
			this.moveTween.reset(this, 0);
		}
		
		update function moveCenter(change:DCellXY, ticksToGo:int):void 
		{
			this.moveTween.reset(this, ticksToGo * Time.TIME_BETWEEN_TICKS);
			this.moveTween.moveTo(this.x - change.x * Metric.CELL_WIDTH, this.y - change.y * Metric.CELL_HEIGHT);
			
			this.juggler.add(this.moveTween);
		}
	}

}