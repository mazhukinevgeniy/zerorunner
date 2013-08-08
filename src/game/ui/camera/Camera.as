package game.ui.camera 
{
	import game.actors.ActorsFeature;
	import game.time.Time;
	import game.ZeroRunner;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import utils.informers.IGiveInformers;
	import utils.informers.IStoreInformers;
	import utils.PixelPerfectTween;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class Camera implements ILines
	{
		private var lines:Vector.<Sprite>;
		private var topLine:int;
		
		private var juggler:Juggler;
		
		private var container:Sprite;
		
		public function Camera(flow:IUpdateDispatcher) 
		{
			var numberOfLines:int = Metric.CELLS_IN_VISIBLE_HEIGHT + 3 + (Metric.CELLS_IN_VISIBLE_HEIGHT % 2 == 0 ? 1 : 0);
			
			this.lines = new Vector.<Sprite>(numberOfLines, true);
			
			
			this.container = new Sprite();
			
			for (var i:int = 0; i < numberOfLines; i++)
				this.container.addChild(this.lines[i] = new Sprite());
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.setCenter);
			flow.addUpdateListener(ActorsFeature.moveCenter);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
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
		
		public function addChildTo(object:DisplayObject, line:int):void
		{
			//if line is not suitable, ignore it
			
			//lol what? ignore nothing, useless requests are not required
			
		}
		
		update function setCenter(center:CellXY):void
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
		update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(ILines, this);
		}
	}
	
}