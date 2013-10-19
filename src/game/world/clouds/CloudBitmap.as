package game.world.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	internal class CloudBitmap extends BitmapData
	{
		
		internal static const WIDTH:Number = 1024;
		internal static const HEIGHT:Number = 1024;
		
		[Embed(source = "../../../../res/assets/textures/atlases/sprites/unimplemented.png")]
		private static const BaseCloud:Class;
		
		public function CloudBitmap(cloudiness:int) 
		{
			super(CloudBitmap.WIDTH, CloudBitmap.HEIGHT, true, 0x00FFFFFF);
			
			var baseCloud:Bitmap = new BaseCloud();
			var numberOfElements:int = int(cloudiness * (Math.random() + 3) / 4);
			
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
						copyNewElement.x = - (CloudBitmap.WIDTH - newElement.x);
					
					if(newElement.y + newElement.height > CloudBitmap.HEIGHT)
						copyNewElement.y = - (CloudBitmap.HEIGHT - newElement.y);
						
					container.addChild(copyNewElement);
				}
				
			}
			
			container.width = CloudBitmap.WIDTH;
			container.height = CloudBitmap.HEIGHT;
			
			this.draw(container);
		}
		
	}

}