package chaotic.ui 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.informers.IGiveInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.DPixelXY;
	import chaotic.metric.Metric;
	import chaotic.metric.PixelXY;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	public class Camera
	{
		public static const SCENE:int = 0;
		public static const ACTORS:int = 1;
		public static const GRINDERS:int = 2;
		
		private static const NUMBER_OF_LAYERS:int = 3;
		
		
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
			
			flow.addUpdateListener("setCenter");
			flow.addUpdateListener("moveCenter");
			flow.addUpdateListener("getInformerFrom");
			flow.addUpdateListener("addToTheLayer");
			
			flow.dispatchUpdate("addToTheHUD", this.container);
		}
		
		public function setCenter(center:CellXY):void
		{
			var pCenter:PixelXY = Metric.toPixel(center);
			
			
			this.container.x = -pCenter.x + (Constants.WIDTH - Metric.CELL_WIDTH) / 2;
            this.container.y = -pCenter.y + (Constants.HEIGHT - Metric.CELL_HEIGHT) / 2;
		}
		
		public function moveCenter(change:DCellXY, ticksToGo:int = 0):void 
		{ 
			this.moveCenterGently(change, ticksToGo * Constants.TIME_BETWEEN_TICKS); 
		}
		
		private function moveCenterGently(change:DCellXY, time:Number):void 
		{ 
			var pChange:DPixelXY = Metric.toPixel(change);
			
			var tween:Tween = new Tween(this.container, time);
			tween.moveTo(this.container.x - pChange.x, this.container.y - pChange.y);
			
			this.juggler.add(tween);
		}
		
		
		public function addToTheLayer(number:int, object:DisplayObject):void
		{
			this.layers[number].addChild(object);
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.juggler = table.getInformer(Juggler);
		}
	}
	
}