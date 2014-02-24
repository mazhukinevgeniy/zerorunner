package view.features.input.directions 
{
	
	internal class Right extends DirectionBase
	{
		
		public function Right(newControls:Directions) 
		{
			this.controls = newControls;
			
			super();
			
 			this.ringPiece.graphics.beginFill(0xCC9966, 0.6);
 			this.ringPiece.graphics.moveTo(90, 0);
 			this.ringPiece.graphics.lineTo(90,90);
 			this.ringPiece.graphics.lineTo(90-15, 90 - 15);
 			this.ringPiece.graphics.lineTo(90-15, 15);
 			this.ringPiece.graphics.lineTo(90, 0);
 			this.ringPiece.graphics.endFill();
			
			
			this.fullTriangle.graphics.beginFill(0xEEEEEE, Number.MIN_VALUE);
			this.fullTriangle.graphics.moveTo(Constants.WIDTH, 0);
			this.fullTriangle.graphics.lineTo(Constants.WIDTH, Constants.HEIGHT);
			this.fullTriangle.graphics.lineTo(Constants.WIDTH / 2, Constants.HEIGHT / 2);
			this.fullTriangle.graphics.lineTo(Constants.WIDTH, 0);
			this.fullTriangle.graphics.endFill();
		}
		
	}

}