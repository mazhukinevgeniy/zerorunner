package game.world 
{
	import game.items.ActorsFeature;
	import game.metric.ICoordinated;
	import game.time.Time;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	import utils.PixelPerfectTween;
	import utils.templates.UpdateGameBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class Camera
	{
		private var container:Sprite;
		private var lines:Vector.<Sprite>;
		
		internal var topLine:int;
		
		internal var scene:QuadBatch;
		
		private var juggler:Juggler;
		
		private var moveTween:PixelPerfectTween;
		
		
		public function Camera(flow:IUpdateDispatcher, juggler:Juggler) 
		{
			this.juggler = juggler;
			
			const numberOfLines:int = Metric.CELLS_IN_VISIBLE_HEIGHT + 6 + Metric.CELLS_IN_VISIBLE_HEIGHT % 2;
			
			this.lines = new Vector.<Sprite>(numberOfLines, true);
			
			
			this.container = new Sprite();
			
			this.scene = new QuadBatch();
			this.container.addChild(this.scene);
			
			for (var i:int = 0; i < numberOfLines; i++)
				this.container.addChild(this.lines[i] = new Sprite());
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.setCenter);
			flow.addUpdateListener(ActorsFeature.moveCenter);
			flow.addUpdateListener(UpdateGameBase.prerestore);
			
			flow.dispatchUpdate(UpdateGameBase.addToTheHUD, this.container);
			
			this.moveTween = new PixelPerfectTween(this, 0);
		}
		
		
		update function prerestore():void
		{
			this.scene.reset();
			
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
			this.moveTween.reset(this.container, ticksToGo * Time.TIME_BETWEEN_TICKS);
			this.moveTween.moveTo(this.container.x - change.x * Metric.CELL_WIDTH, this.container.y - change.y * Metric.CELL_HEIGHT);
			
			this.juggler.add(this.moveTween);
		}
	}
	
}