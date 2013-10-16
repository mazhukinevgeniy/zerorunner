package game.world.renderer 
{
	import data.structs.GameConfig;
	import game.core.GameFoundations;
	import game.core.metric.*;
	import game.core.time.Time;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import utils.PixelPerfectTween;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Camera
	{
		private var container:Sprite;
		
		internal var actors:Sprite;
		internal var scene:QuadBatch;
		
		private var juggler:Juggler;
		
		private var moveTween:PixelPerfectTween;
		
		
		public function Camera(foundations:GameFoundations) 
		{
			this.juggler = foundations.juggler;
			var flow:IUpdateDispatcher = foundations.flow;
			
			this.container = new Sprite();
			this.container.addChild(this.scene = new QuadBatch());
			this.container.addChild(this.actors = new Sprite());
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(Update.setCenter);
			flow.addUpdateListener(Update.moveCenter);
			flow.addUpdateListener(Update.prerestore);
			
			foundations.displayRoot.addChild(this.container);
			
			this.moveTween = new PixelPerfectTween(this, 0);
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.scene.reset();
			this.actors.removeChildren();
		}
		
		update function setCenter(center:ICoordinated):void
		{
			this.container.x = -center.x * Metric.CELL_WIDTH + (Main.WIDTH - Metric.CELL_WIDTH) / 2;
            this.container.y = -center.y * Metric.CELL_HEIGHT + (Main.HEIGHT - Metric.CELL_HEIGHT) / 2;
			
			this.moveTween.reset(this, 0);
		}
		
		update function moveCenter(change:DCellXY, ticksToGo:int):void 
		{
			this.moveTween.reset(this.container, ticksToGo * Time.TIME_BETWEEN_TICKS);
			this.moveTween.moveTo(this.container.x - change.x * Metric.CELL_WIDTH, this.container.y - change.y * Metric.CELL_HEIGHT);
			
			this.juggler.add(this.moveTween);
		}
		
		
		internal function addChild(item:DisplayObject):void
		{
			this.container.addChild(item);
		}
	}
	
}