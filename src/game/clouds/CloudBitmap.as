package game.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	internal class CloudBitmap extends BitmapData
	{
		
		internal static const WIDTH:Number = 1024;
		internal static const HEIGHT:Number = 1024;
		
		private static const MAX_NUMBER_OF_ELEMENTS:int = 165;
		private static const MIN_NUMBER_OF_ELEMENTS:int = 5;
		private static const STEP:int = (CloudBitmap.MAX_NUMBER_OF_ELEMENTS - CloudBitmap.MIN_NUMBER_OF_ELEMENTS) / Clouds.SIZE_CLOUDINNESS_SCALE;
		
		[Embed(source="../../../res/textures/clouds/unimplemented.png")]
		private static const BaseCloud:Class;
		
		public function CloudBitmap(cloudiness:int) 
		{
			super(CloudBitmap.WIDTH, CloudBitmap.HEIGHT, true, 0x00FFFFFF);
			
			var baseCloud:Bitmap = new BaseCloud();
			var numberOfElements:int = cloudiness * CloudBitmap.STEP + CloudBitmap.MIN_NUMBER_OF_ELEMENTS + 
									   (Math.random() * 100) % CloudBitmap.STEP ;
			
			var dataBaseCloud:BitmapData = baseCloud.bitmapData; 
			var container:Sprite = new Sprite();
			
			for (var i:int = 0; i < numberOfElements; ++i)
			{
				var newElement:Bitmap = new Bitmap(dataBaseCloud.clone())
				var copyNewElement:Bitmap;

				newElement.x = Math.random() * CloudBitmap.WIDTH;
				newElement.y = Math.random() * CloudBitmap.HEIGHT;
				container.addChild(newElement);
				
				if (newElement.x + newElement.width > CloudBitmap.WIDTH || 
					newElement.y + newElement.height > CloudBitmap.HEIGHT)
				{
					copyNewElement = new Bitmap(dataBaseCloud.clone());
					
					copyNewElement.x = newElement.x;
					copyNewElement.y = newElement.y;
					
					if(newElement.x + newElement.width > CloudBitmap.WIDTH)
						copyNewElement.x = int(newElement.x - CloudBitmap.WIDTH);
					
					if(newElement.y + newElement.height > CloudBitmap.HEIGHT)
						copyNewElement.y = int(newElement.y - CloudBitmap.HEIGHT);
						
					container.addChild(copyNewElement);
				}
				if (newElement.x + newElement.width > CloudBitmap.WIDTH && 
					newElement.y + newElement.height > CloudBitmap.HEIGHT)
				{
					var copyUp:Bitmap = new Bitmap(dataBaseCloud.clone());
					var copyLeft:Bitmap = new Bitmap(dataBaseCloud.clone());
					
					copyUp.x = newElement.x;
					copyUp.y = int(newElement.y - CloudBitmap.HEIGHT);
					
					copyLeft.x = int(newElement.x - CloudBitmap.WIDTH);
					copyLeft.y = newElement.y;
					
					container.addChild(copyUp);
					container.addChild(copyLeft);
				}
				
			}
			
			container.width = CloudBitmap.WIDTH;
			container.height = CloudBitmap.HEIGHT;
			
			this.draw(container);
		}
		
	}

}