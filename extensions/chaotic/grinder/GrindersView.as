package chaotic.grinder 
{
	import chaotic.informers.IGiveInformers;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	import chaotic.metric.Metric;
	import chaotic.metric.PixelXY;
	import chaotic.ui.Camera;
	import chaotic.updates.IUpdateDispatcher;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	internal class GrindersView
	{
		private var streams:Vector.<Quad>;
		
		private var topID:int;
		private var centerChange:int;
		
		private var container:Sprite;
		
		private const GRINDER_WIDTH:int = Constants.WIDTH * 2;
		private const GRINDER_HEIGHT:int = GrinderFeature.HEIGHT * Metric.CELL_HEIGHT;
		
		private var juggler:Juggler;
		
		public function GrindersView(flow:IUpdateDispatcher) 
		{
			this.streams = new Vector.<Quad>();
			
			this.container = new Sprite();
			
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener("addGrinders");
			flow.addUpdateListener("grindingStreamMoved");
			flow.addUpdateListener("setCenter");
			flow.addUpdateListener("moveCenter");
			flow.addUpdateListener("getInformerFrom");
			
			flow.dispatchUpdate("addToTheLayer", Camera.GRINDERS, this.container);
		}
		
		public function addGrinders(vector:Vector.<GrindingStream>):void
		{
			this.container.removeChildren();
			
			var length:int = vector.length;
			for (var i:int = 0; i < length; i++)
			{
				var item:GrindingStream = vector[i];
				
				this.streams[item.id] = new Quad(this.GRINDER_WIDTH, this.GRINDER_HEIGHT, 0x000000);
				this.streams[item.id].x = item.front * Metric.CELL_WIDTH - this.GRINDER_WIDTH;
				this.streams[item.id].y = item.id * this.GRINDER_HEIGHT;
				
				this.container.addChild(this.streams[item.id]);
			}
		}
		
		
		
		public function grindingStreamMoved(id:int, change:int):void
		{
			var stream:DisplayObject = this.streams[id];
			
			var tween:Tween = new Tween(stream, GrinderFeature.TIME_MIN * Constants.TIME_BETWEEN_TICKS);
			tween.animate("x", stream.x + change * Metric.CELL_WIDTH);
			
			this.juggler.add(tween);
		}
		
		public function setCenter(center:CellXY):void
		{
			/*
			 * Подразумевается, что этот метод вызван /после/ создания гриндеров.
			 */
			
			var pCenter:PixelXY = Metric.toPixel(center);
			
			var topLine:int = pCenter.y - Metric.CELL_HEIGHT * Metric.CELLS_IN_VISIBLE_HEIGHT;
			
			var length:int = this.streams.length;
			
			var absoluteTopStream:int = topLine / this.GRINDER_HEIGHT;
			this.topID = absoluteTopStream % length;
			
			for (var i:int = 0; i < length; i++)
			{
				this.streams[(this.topID + i) % length].y = (absoluteTopStream + i) * this.GRINDER_HEIGHT;
			}
			
			this.centerChange = 0;
		}
		
		public function moveCenter(change:DCellXY, ticksToGo:int = 0):void
		{
			this.centerChange += change.y;
			
			var length:int = this.streams.length;
			
			if (this.centerChange >= this.GRINDER_HEIGHT / Metric.CELL_HEIGHT)
			{
				this.streams[this.topID].y = 
				  this.streams[(this.topID - 1 + length) % length].y +
				    this.GRINDER_HEIGHT;
				this.topID = (this.topID + 1) % length;
				
				this.centerChange = 0;
			}
			else if (this.centerChange <= -this.GRINDER_HEIGHT / Metric.CELL_HEIGHT)
			{
				this.streams[(this.topID - 1 + length) % length].y = 
				  this.streams[this.topID].y -
				    this.GRINDER_HEIGHT;
				this.topID = (this.topID - 1 + length) % length;
				
				this.centerChange = 0;
			}
		}
		
		public function getInformerFrom(table:IGiveInformers):void
		{
			this.juggler = table.getInformer(Juggler);
		}
	}

}