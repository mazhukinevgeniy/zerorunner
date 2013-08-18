package game.world.broods 
{
	import game.utils.metric.DCellXY;
	import game.utils.metric.ICoordinated;
	import game.utils.metric.Metric;
	import game.utils.time.Time;
	import starling.animation.Juggler;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import utils.PixelPerfectTween;
	
	public class ItemViewBase extends Sprite
	{
		protected var juggler:Juggler;
		protected var atlas:TextureAtlas;
		
		private var movingTween:PixelPerfectTween;
		
		
		public function ItemViewBase() 
		{
			this.juggler = BroodmotherBase.juggler;
			this.atlas = BroodmotherBase.gameAtlas;
			
			super();
			this.addChild(this.getView());
			
			this.movingTween = new PixelPerfectTween(this, 0);
		}
		
		
		protected function getView():DisplayObject
		{
			return new Image(this.atlas.getTexture("unimplemented"));
		}
		
		final internal function standOn(cell:ICoordinated):void
		{
			this.x = cell.x * Metric.CELL_WIDTH;
			this.y = cell.y * Metric.CELL_HEIGHT;
			
			this.movingTween.reset(this, 0);
			
			this.visible = true;
		}
		
		final internal function moveNormally(goal:ICoordinated, change:DCellXY, delay:int):void
		{
			this.movingTween.reset(this, delay * Time.TIME_BETWEEN_TICKS);
			this.movingTween.moveTo(goal.x * Metric.CELL_WIDTH, goal.y * Metric.CELL_HEIGHT);
			
			this.juggler.add(this.movingTween);
			
			this.animateMove(change, delay);
		}
		
		final internal function jump(goal:ICoordinated, change:DCellXY, delay:int):void
		{
			this.movingTween.reset(this, delay * Time.TIME_BETWEEN_TICKS);
			this.movingTween.moveTo(goal.x * Metric.CELL_WIDTH, goal.y * Metric.CELL_HEIGHT);
			
			this.juggler.add(this.movingTween);
			
			this.animateJump(change, delay);
		}
		
		final internal function solder(target:ICoordinated, delay:int):void
		{			
			this.animateSoldering(target, delay);
		}
		
		final internal function disappear():void
		{
			this.movingTween.reset(this, 0);
			
			this.visible = false;
		}
		
		protected function animateMove(change:DCellXY, delay:int):void
		{
			
		}
		
		protected function animateSoldering(target:ICoordinated, delay:int):void
		{
			throw new Error();
		}
		
		protected function animateJump(change:DCellXY, delay:int):void
		{
			
		}
	}

}