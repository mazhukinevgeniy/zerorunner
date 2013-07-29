package game.ui 
{
	import game.actors.ActorsFeature;
	import game.time.Time;
	import game.ZeroRunner;
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.informers.IGiveInformers;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.ZeroRunner;
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import utils.PixelPerfectTween;
	
	public class Camera
	{
		public static const SCENE:int = 0;
		public static const ACTORS:int = 1;
		public static const GRINDERS:int = 2;
		
		private static const NUMBER_OF_LAYERS:int = 3;
		
		public static const addToTheLayer:String = "addToTheLayer";
		
		private var container:Sprite;
		private var layers:Vector.<Sprite>;
		
		private var juggler:Juggler;
		
		public function Camera(flow:IUpdateDispatcher) 
		{
			this.container = new Sprite();
			
			this.layers = new Vector.<Sprite>(Camera.NUMBER_OF_LAYERS, true);
			
			for (var i:int = 0; i < Camera.NUMBER_OF_LAYERS; i++)
				this.container.addChild(this.layers[i] = new Sprite());
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ActorsFeature.setCenter);
			flow.addUpdateListener(ActorsFeature.moveCenter);
			flow.addUpdateListener(ZeroRunner.getInformerFrom);
			flow.addUpdateListener(Camera.addToTheLayer);
			
			flow.dispatchUpdate(ZeroRunner.addToTheHUD, this.container);
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
		
		
		update function addToTheLayer(number:int, object:DisplayObject):void
		{
			this.layers[number].addChild(object);
		}
		
		update function getInformerFrom(table:IGiveInformers):void
		{
			this.juggler = table.getInformer(Juggler);
		}
	}
	
}