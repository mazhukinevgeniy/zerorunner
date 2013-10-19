package game.world.clouds 
{
	import flash.events.Event;
	import game.GameElements;
	import starling.core.Starling;
	import starling.extensions.krecha.ScrollTile;
	
	internal class Cloud extends ScrollTile
	{
		private var dX:int;
		private var dY:int;
		private var dA:Number;
		
		public function Cloud(foundations:GameElements, cloudiness:int = 0) 
		{
			do
			{
				this.dX = Math.random() * 2 * (Math.random() < 0.5 ? 1 : -1);
				this.dY = Math.random() * 2 * (Math.random() < 0.5 ? 1 : -1);
			}
			while (this.dX == 0 && this.dY == 0);
			
			super(foundations.assets.getTexture("testcloud"));
			/*
			super();
			
			var piece:Image = new Image(foundations.atlas.getTexture("unimplemented"));
			piece.scaleX = piece.scaleY = 0.49;
			
			const width:int = 5;
			const height:int = 9;
			
			for (var i:int = 0; i < width * height; i++)
				if (Math.random() < 0.8)
				{
					piece.x = (i % width) * Metric.CELL_WIDTH / 2;
					piece.y = (i / width) * Metric.CELL_HEIGHT / 2;
					
					this.addImage(piece);
					
					//TODO: might want to make sure it's the single piece
				}*/
				
				//TODO: delete?
				
				//TODO: generate big cloud textures
			
			Starling.current.nativeStage.addEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
		}
		
		internal function die():void
		{
			Starling.current.nativeStage.removeEventListener(Event.ENTER_FRAME, this.handleEnterFrame);
		}
		
		private function handleEnterFrame(event:Event):void
		{
			this.offsetX += this.dX;
			this.offsetY += this.dY;
		}
	}

}