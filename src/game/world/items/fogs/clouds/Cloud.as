package game.world.items.fogs.clouds 
{
	
	public class Cloud 
	{
		private var activePieces:Vector.<CloudPiece>;
		private var pooledPieces:Vector.<CloudPiece>;
		
		public function Cloud() 
		{
			
			this.activePieces = new Vector.<CloudPiece>();
			this.pooledPieces = new Vector.<CloudPiece>();
		}
		
		public function act():void
		{
			if (this.activePieces.length > 0)
			{
				
			}
			else if (Math.random() < 0.4) 
				this.reset();
		}
		
		private function reset():void
		{
			var tmpv:Vector.<CloudPiece> = this.activePieces;
			this.activePieces = this.pooledPieces;
			this.pooledPieces = tmpv;
			
			//TODO: choose the moving rule, then place the pieces somewhere
		}
	}

}