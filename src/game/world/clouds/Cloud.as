package game.world.clouds 
{
	import game.core.GameFoundations;
	import game.core.metric.Metric;
	import starling.animation.Juggler;
	import starling.animation.Tween;
	import starling.display.Image;
	import starling.display.QuadBatch;
	import starling.display.Sprite;
	
	internal class Cloud extends Sprite
	{
		private var batch:QuadBatch;
		
		private var rotationTween:Tween;
		private var shakeTween:Tween;
		
		private var juggler:Juggler;
		
		
		private const rotationPeriod:int = 1;
		private const shakePeriod:int = 3;
		
		public function Cloud(foundations:GameFoundations) 
		{
			this.batch = new QuadBatch();
			
			var juggler:Juggler = foundations.juggler;
			
			var piece:Image = new Image(foundations.atlas.getTexture("unimplemented"));
			piece.scaleX = piece.scaleY = 0.49;
			
			var width:int = 5;
			var height:int = 9;
			
			for (var i:int = 0; i < width * height; i++)
				if (Math.random() < 0.8)
				{
					piece.x = (i % width) * Metric.CELL_WIDTH / 2;
					piece.y = (i / width) * Metric.CELL_HEIGHT / 2;
					
					this.batch.addImage(piece);
					
					//TODO: might want to make sure it's the single piece
				}
			
			super();
			
			this.batch.x = Metric.CELL_WIDTH * 5;
			
			this.addChild(this.batch);
			
			this.rotationTween = new Tween(this, this.rotationPeriod);
			this.rotationTween.animate("rotation", this.rotation + Math.PI);
			this.rotationTween.onComplete = this.resetRotation;
			
			this.shakeTween = new Tween(this.batch, this.shakePeriod);
			this.shakeTween.animate("x", Metric.CELL_WIDTH * 2);
			this.shakeTween.repeatCount = 0;
			this.shakeTween.reverse = true;
			
			juggler.add(this.rotationTween);
			juggler.add(this.shakeTween);
			
			this.juggler = juggler;
		}
		
		private function resetRotation():void
		{
			this.rotationTween.reset(this, this.rotationPeriod);
			this.rotationTween.animate("rotation", this.rotation + Math.PI);
			this.rotationTween.onComplete = this.resetRotation;
			
			this.juggler.add(this.rotationTween);
		}
		
		internal function stopAll():void
		{
			this.rotationTween.repeatCount = 1;
			this.shakeTween.repeatCount = 1;
			
			//TODO: not required, if juggler is purged on gamestop
		}
	}

}