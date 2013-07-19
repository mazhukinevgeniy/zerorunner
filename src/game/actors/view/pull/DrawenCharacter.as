package game.actors.view.pull 
{
	import game.actors.view.DrawenActor;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.time.Time;
	import starling.animation.Tween;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	public class DrawenCharacter extends DrawenActor
	{
		private var stand:Image;
		
		private var sideWalking:Vector.<MovieClip>;
		
		private var sidewalk:int;
		
		public function DrawenCharacter() 
		{
			
		}
		
		override protected function draw():void
		{
			this.stand = new Image(this.atlas.getTexture("hero_stand"));
			this.addChild(this.stand);
			
			this.sideWalking = new Vector.<MovieClip>(2, true);
			
			for (var i:int = 0; i < 2; i++)
			{
				var animation:MovieClip = new MovieClip(this.atlas.getTextures("hero_side_" + String(i)), 1);
				animation.loop = false;
				this.addChild(animation);
				
				animation.visible = false;
				animation.addEventListener(Event.COMPLETE, this.handleWalkingComplete);
				
				this.sideWalking[i] = animation;
			}
			
			this.sidewalk = 0;
		}
		
		protected function handleWalkingComplete(event:Event):void
		{
			this.stand.visible = true;
			(event.target as DisplayObject).visible = false;
		}
		
		override public function standOn(cell:CellXY):void
		{
			this.x = cell.x * Metric.CELL_WIDTH + (Metric.CELL_WIDTH - this.width) / 2;
			this.y = (cell.y - 1) * Metric.CELL_HEIGHT;
		}
		
		override public function moveNormally(change:DCellXY, delay:int):void
		{
			var tween:Tween;
			
			if (change.x == 0)
			{
				tween = new Tween(this, delay * Time.TIME_BETWEEN_TICKS);
				tween.moveTo(this.x, this.y + change.y * Metric.CELL_HEIGHT);
				
				tween.roundToInt = true;
				
				this.juggler.add(tween);
			}
			else
			{
				this.stand.visible = false;
				
				var animation:MovieClip = this.sideWalking[this.sidewalk];
				
				this.sidewalk++;
				this.sidewalk %= 2;
				
				animation.visible = true;
				
				animation.fps = Number(animation.numFrames / (delay * Time.TIME_BETWEEN_TICKS));
				animation.stop();
				this.juggler.add(animation);
				animation.play();
				
				var oldSX:int = this.scaleX;
				this.scaleX = change.x > 0 ? -1 : 1;
				
				this.x += animation.width * (oldSX - this.scaleX) / 2;
				
				tween = new Tween(this, delay * Time.TIME_BETWEEN_TICKS);
				tween.moveTo(this.x + change.x * Metric.CELL_WIDTH, this.y);
				
				tween.roundToInt = true;
				
				this.juggler.add(tween);
			}
		}
	}

}