package game.actors.types 
{
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.metric.Metric;
	import game.time.Time;
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import utils.PixelPerfectTween;
	
	public class ActorViewBase extends Sprite
	{
		protected var juggler:Juggler;
		protected var atlas:TextureAtlas;
		
		public function ActorViewBase()
		{
			this.juggler = BroodmotherBase.juggler;
			this.atlas = BroodmotherBase.gameAtlas;
			
			super();
			this.addChild(this.getView());
		}
		
		protected function getView():DisplayObject
		{
			return new Image(this.atlas.getTexture("unimplemented"));
		}
		
		final internal function standOn(cell:ICoordinated):void
		{
			this.x = cell.x * Metric.CELL_WIDTH;
			this.y = cell.y * Metric.CELL_HEIGHT;
			
			this.visible = true;
		}
		
		final internal function moveNormally(goal:ICoordinated, change:DCellXY, delay:int):void
		{
			var tween:PixelPerfectTween = new PixelPerfectTween(this, delay * Time.TIME_BETWEEN_TICKS);
			tween.moveTo(goal.x * Metric.CELL_WIDTH, goal.y * Metric.CELL_HEIGHT);
			
			this.juggler.add(tween);
			
			this.animateMove(change, delay);
		}
		
		final internal function disappear():void
		{
			
			
			this.visible = false;
		}
		
		protected function animateMove(change:DCellXY, delay:int):void
		{
			
		}
		
		public function jump(change:DCellXY, delay:int):void
		{
			
		}
	}

}