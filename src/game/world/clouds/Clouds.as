package game.world.clouds 
{
	import game.core.GameFoundations;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.core.time.Time;
	import starling.display.Sprite;
	import utils.PixelPerfectTween;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Clouds extends Sprite
	{
		private var foundations:GameFoundations;
		
		private var centerCloud:Cloud;
		
		private var moveTween:PixelPerfectTween;
		
		public function Clouds(foundations:GameFoundations) 
		{
			super();
			
			this.moveTween = new PixelPerfectTween(this, 0);
			this.foundations = foundations;
			
			var flow:IUpdateDispatcher = foundations.flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.setCenter);
			flow.addUpdateListener(Update.moveCenter);
			flow.addUpdateListener(Update.gameStopped);
			flow.addUpdateListener(Update.quitGame);
		}
		
		update function setCenter(item:ICoordinated):void
		{
			this.centerCloud = new Cloud(this.foundations);
			this.addChild(this.centerCloud);
			
			var anotherOne:Cloud = new Cloud(foundations);
			anotherOne.rotation = 2;
			this.centerCloud.addChild(anotherOne);
			
			//TODO: this code is bad, change it
			
			this.centerCloud.x = item.x * Metric.CELL_WIDTH;
			this.centerCloud.y = item.y * Metric.CELL_HEIGHT;
		}
		
		update function moveCenter(change:DCellXY, ticksToGo:int):void 
		{
			this.moveTween.reset(this.centerCloud, ticksToGo * Time.TIME_BETWEEN_TICKS);
			this.moveTween.moveTo(this.centerCloud.x + change.x * Metric.CELL_WIDTH, this.centerCloud.y + change.y * Metric.CELL_HEIGHT);
			
			this.foundations.juggler.add(this.moveTween);
		}
		
		update function gameStopped():void
		{
			this.centerCloud.stopAll();
		}
		
		update function quitGame():void
		{
			this.removeChildren();
		}
	}

}