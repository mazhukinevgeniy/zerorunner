package game.world.clouds 
{
	import game.core.GameFoundations;
	import starling.extensions.krecha.ScrollTile;
	
	internal class Cloud extends ScrollTile
	{
		
		public function Cloud(foundations:GameFoundations) 
		{
			
			
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
		}
		
	}

}