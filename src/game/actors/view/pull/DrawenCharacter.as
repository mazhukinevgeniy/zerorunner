package game.actors.view.pull 
{
	import game.actors.view.DrawenActor;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	import game.metric.Metric;
	import game.time.Time;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.events.Event;
	
	public class DrawenCharacter extends DrawenActor
	{
		private var stand:Image;
		
		private var sideWalking:MovieClip;
		
		public function DrawenCharacter() 
		{
			
		}
		
		override protected function draw():void
		{
			this.stand = new Image(this.atlas.getTexture("hero_stand"));
			this.addChild(this.stand);
			
			this.sideWalking = new MovieClip(this.atlas.getTextures("hero_side_"), 1);
			this.sideWalking.loop = false;
			this.addChild(this.sideWalking);
			
			this.sideWalking.visible = false;
			this.sideWalking.addEventListener(Event.COMPLETE, this.handleWalkingComplete);
		}
		
		protected function handleWalkingComplete():void
		{
			this.stand.visible = true;
			this.sideWalking.visible = false;
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
				this.sideWalking.visible = true;
				
				this.sideWalking.fps = Number(this.sideWalking.numFrames / (delay * Time.TIME_BETWEEN_TICKS));
				this.sideWalking.stop();
				this.juggler.add(this.sideWalking);
				this.sideWalking.play();
				
				var oldSX:int = this.scaleX;
				this.scaleX = change.x > 0 ? -1 : 1;
				
				this.x += this.sideWalking.width * (oldSX - this.scaleX) / 2;
				
				tween = new Tween(this, delay * Time.TIME_BETWEEN_TICKS);
				tween.moveTo(this.x + change.x * Metric.CELL_WIDTH, this.y);
				
				tween.roundToInt = true;
				
				this.juggler.add(tween);
			}
		}
	}

}