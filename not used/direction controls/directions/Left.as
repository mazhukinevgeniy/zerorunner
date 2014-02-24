package view.features.input.directions 
{
	
	internal class Left extends DirectionBase
	{
		
		public function Left(newControls:Directions) 
		{
			this.controls = newControls;
			
			super();
			
 			this.ringPiece.graphics.beginFill(0xCC9966, 0.6);
 			this.ringPiece.graphics.moveTo(0, 0);
 			this.ringPiece.graphics.lineTo(15,15);
 			this.ringPiece.graphics.lineTo(15, 90 - 15);
 			this.ringPiece.graphics.lineTo(0, 90);
 			this.ringPiece.graphics.lineTo(0, 0);
 			this.ringPiece.graphics.endFill();
			
			this.fullTriangle.graphics.beginFill(0xEEEEEE, Number.MIN_VALUE);
			this.fullTriangle.graphics.moveTo(0, 0);
			this.fullTriangle.graphics.lineTo(0, Constants.HEIGHT);
			this.fullTriangle.graphics.lineTo(Constants.WIDTH / 2, Constants.HEIGHT / 2);
			this.fullTriangle.graphics.lineTo(0, 0);
			this.fullTriangle.graphics.endFill();
		}
		
	}

}