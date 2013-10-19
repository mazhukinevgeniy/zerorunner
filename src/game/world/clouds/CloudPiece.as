package game.world.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class CloudPiece extends Sprite
	{
		private var dataBaseCloud:BitmapData;
		
		public function CloudPiece(numberOfElements:int, baseCloud:Bitmap)
		{
			var size:Number = Math.sqrt(numberOfElements);
			
			this.dataBaseCloud = baseCloud.bitmapData;
			
			for (var i:int = 0; i < numberOfElements; ++i)
			{
				var newElement:Bitmap = new Bitmap(this.dataBaseCloud.clone())
				var copyNewElement:Bitmap;

				newElement.x = Math.random() * CloudTexture.WIDTH;
				newElement.y = Math.random() * CloudTexture.HEIGHT;
				this.addChild(newElement);
				
				if (newElement.x + newElement.width > CloudTexture.WIDTH || 
					newElement.y + newElement.height > CloudTexture.HEIGHT)
				{
					copyNewElement = new Bitmap(this.dataBaseCloud.clone());
					
					copyNewElement.x = newElement.x;
					copyNewElement.y = newElement.y;
					
					if(newElement.x + newElement.width > CloudTexture.WIDTH)
						copyNewElement.x = - (CloudTexture.WIDTH - newElement.x);
					
					if(newElement.y + newElement.height > CloudTexture.HEIGHT)
						copyNewElement.y = - (CloudTexture.HEIGHT - newElement.y);
						
					this.addChild(copyNewElement);
				}
				
			}
			
			this.width = CloudTexture.WIDTH;
			this.height = CloudTexture.HEIGHT;
		}
		
	}

}