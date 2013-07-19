package game.actors.view 
{
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.time.Time;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	
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
		}
		
		public function moveNormally(change:DCellXY, delay:int):void
		{
			var tween:Tween = new Tween(this, delay * Time.TIME_BETWEEN_TICKS);
			tween.moveTo(this.x + change.x * Metric.CELL_WIDTH, this.y + change.y * Metric.CELL_HEIGHT);
			
			tween.roundToInt = true;
			
			DrawenActor.iJuggler.add(tween);
		}
		
		public function jump(change:DCellXY, delay:int):void
		{
			var tween:Tween, secondTween:Tween;
			
			if (change.y != 0)
			{
				tween = new Tween(this, delay * Time.TIME_BETWEEN_TICKS / 2, "easeIn");
				tween.animate("y", this.y + change.y * Metric.CELL_HEIGHT / 2);
				tween.scaleTo(1.5);
				
				secondTween = new Tween(this, delay * Time.TIME_BETWEEN_TICKS / 2, "easeOut");
				secondTween.animate("y", this.y + change.y * Metric.CELL_HEIGHT);
				secondTween.scaleTo(1);
				
				tween.nextTween = secondTween;
				
				DrawenActor.iJuggler.add(tween);
			}
			else
			{
				tween = new Tween(this, delay * Time.TIME_BETWEEN_TICKS / 2, "easeIn");
				tween.animate("y", this.y - Metric.CELL_HEIGHT / 2);
				tween.animate("x", this.x + change.x * Metric.CELL_WIDTH / 2);
				
				secondTween = new Tween(this, delay * Time.TIME_BETWEEN_TICKS / 2, "easeOut");
				secondTween.animate("y", this.y);
				secondTween.animate("x", this.x + change.x * Metric.CELL_WIDTH);
				
				tween.nextTween = secondTween;
				
				DrawenActor.iJuggler.add(tween);
			}
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