package view.shell.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	internal class CloudBitmap extends BitmapData
	{
		internal static const WIDTH:Number = 256;
		internal static const HEIGHT:Number = 256;
		
		[Embed(source="../../../../res/clouds/unimplemented.png")]
		private static const BaseCloud:Class;
		
		public function CloudBitmap(cloudiness:int) 
		{
			super(CloudBitmap.WIDTH, CloudBitmap.HEIGHT, true, 0x00FFFFFF);
			
			var baseCloud:Bitmap = new CloudBitmap.BaseCloud();
			var numberOfElements:int = 1 + Math.random() * cloudiness;
			
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