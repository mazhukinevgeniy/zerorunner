package game.world.clouds 
{

	public class CloudGenerator 
	{
		private static const NUMBER_OF_SECTORS_IN_WIDTH:int = 4;
		private static const NUMBER_OF_SECTORS_IN_HEIGHT:int = 3;
		
		private static const NUMBER_OF_SECTORS:int = Cloud.NUMBER_OF_SECTORS_IN_WIDTH * Cloud.NUMBER_OF_SECTORS_IN_HEIGHT;
		
		public function CloudGenerator() 
		{
			var cloudiness:Number = Math.random() * Math.random();
			
			for (var i:int = 0; i < Cloud.NUMBER_OF_SECTORS; ++i)
			{
				var empty:Boolean = Math.random() < cloudiness ? false : true;
				
				if (!empty)
				{
					this.generateCloudPiece();
				}
			}			
		}
		
	}

}