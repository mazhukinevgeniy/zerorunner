package game.world.clouds 
{
	import flash.display.BitmapData;
	import starling.textures.Texture;

	public class CloudTexture extends Texture
	{
		private static const NUMBER_OF_SECTORS_IN_WIDTH:int = 4;
		private static const NUMBER_OF_SECTORS_IN_HEIGHT:int = 3;
		
		private static const NUMBER_OF_CELLS_IN_WIDTH:int = 16;
		private static const NUMBER_OF_CELLS_IN_HEIGHT:int = 12;
		
		
		private static const NUMBER_OF_SECTORS:int = Cloud.NUMBER_OF_SECTORS_IN_WIDTH * Cloud.NUMBER_OF_SECTORS_IN_HEIGHT;
		
		public function CloudTexture() 
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
		
		private function generateCloudPiece();
		{
			var bmpData:BitmapData = new BitmapData(100, 100, true, 0x0);
			
			bmpData.draw(shape);
		}
		
	}

}