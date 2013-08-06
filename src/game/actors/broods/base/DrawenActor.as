package game.actors.broods.base 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.time.Time;
	import starling.animation.Juggler;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import utils.PixelPerfectTween;
	
	public class DrawenActor extends Sprite
	{
		internal static var iJuggler:Juggler;
		internal static var iAtlas:TextureAtlas;
		
		public function DrawenActor()
		{
			super();
			this.draw();
		}
		
		protected function draw():void
		{
			var image:Image = new Image(DrawenActor.iAtlas.getTexture("unimplemented"));
			this.addChild(image);
		}
		
		public function standOn(cell:CellXY):void
		{
			this.x = cell.x * Metric.CELL_WIDTH;
			this.y = cell.y * Metric.CELL_HEIGHT;
			
			trace(this.x, this.y);
		}
		
		public function moveNormally(goal:CellXY, change:DCellXY, delay:int):void
		{
			
		}
		
		public function jump(change:DCellXY, delay:int):void
		{
			
		}
		
		
		final protected function get juggler():Juggler
		{
			return DrawenActor.iJuggler;
		}
		final protected function get atlas():TextureAtlas
		{
			return DrawenActor.iAtlas;
		}
	}

}