package game.world 
{
	import game.actors.ActorsFeature;
	import game.metric.ICoordinated;
	import game.time.Time;
	import game.ZeroRunner;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Sprite;
	import utils.informers.IGiveInformers;
	import utils.PixelPerfectTween;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Camera
	{
		private var container:Sprite;
		private var lines:Vector.<Sprite>;
		
		internal var topLine:int;
		
		private var juggler:Juggler;
		
		
		public function Camera(flow:IUpdateDispatcher) 
		{
			var numberOfLines:int = Metric.CELLS_IN_VISIBLE_HEIGHT + 6 + Metric.CELLS_IN_VISIBLE_HEIGHT % 2;
			
			this.lines = new Vector.<Sprite>(numberOfLines, true);
			
			
			this.container = new Sprite();
			
			for (var i:int = 0; i < numberOfLines; i++)
				this.container.addChild(this.lines[i] = new Sprite());
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.setCenter);
			flow.addUpdateListener(ActorsFeature.moveCenter);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			flow.addUpdateListener(ZeroRunner.redraw);
			
			flow.dispatchUpdate(ZeroRunner.addToTheHUD, this.container);
		}
		
		update function redraw():void
		{
			var length:int = this.lines.length;
			
			for (var i:int = 0; i < length; i++)
			{
				this.lines[i].removeChildren();
			}
		}
		
		internal function getLine(y:int):DisplayObjectContainer
		{
			return this.lines[y - this.topLine];
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.container.x = -center.x * Metric.CELL_WIDTH + (Main.WIDTH - Metric.CELL_WIDTH) / 2;
            this.container.y = -center.y * Metric.CELL_HEIGHT + (Main.HEIGHT - Metric.CELL_HEIGHT) / 2;
		}
		
		update function moveCenter(change:DCellXY, ticksToGo:int):void 
		{
			var tween:PixelPerfectTween = new PixelPerfectTween(this.container, ticksToGo * Time.TIME_BETWEEN_TICKS);
			tween.moveTo(this.container.x - change.x * Metric.CELL_WIDTH, this.container.y - change.y * Metric.CELL_HEIGHT);
			
			this.juggler.add(tween);
		}
		
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			this.juggler = table.getInformer(Juggler);
		}
	}
	
}