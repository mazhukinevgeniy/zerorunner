package game.world.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class CloudPiece extends Sprite
	{
		private var elements:Vector.<Bitmap>;
		private var dataBaseCloud:BitmapData;
		
		public function CloudPiece(numberOfElements:int, baseCloud:Bitmap)
		{
			var size:Number = Math.sqrt(numberOfElements);
			
			this.elements = new Vector.<Bitmap>;
			this.dataBaseCloud = baseCloud.bitmapData;
			
			//this.widthCloudPiece = (size * baseCloud.width * 3) / 3;
			//this.heightCloudPiece = (size * baseCloud.height * 3) / 3;
			
			for (var i:int = 0, j:int = 0; i < numberOfElements; ++i, ++j)
			{
				var newElement:Bitmap = new Bitmap(this.dataBaseCloud.clone())
				var copyNewElement:Bitmap;
				
				this.elements.push(newElement);
				this.elements[j].x = Math.random() * CloudTexture.WIDTH;
				this.elements[j].y = Math.random() * CloudTexture.HEIGHT;
				this.addChild(elements[j]);
				
				if (this.elements[j].x + newElement.width > CloudTexture.WIDTH || 
					this.elements[j].y + newElement.height > CloudTexture.HEIGHT)
				{
					trace(this.elements[j].x, this.elements[j].y);
					copyNewElement = new Bitmap(new BitmapData(40, 40, true, 0xFFFF0000));
					this.elements.push(copyNewElement);
					++j;
					
					this.elements[j].x = this.elements[j-1].x;
					this.elements[j].y = this.elements[j-1].y;
					
					if(this.elements[j-1].x + newElement.width > CloudTexture.WIDTH)
						this.elements[j].x = - (CloudTexture.WIDTH - this.elements[j - 1].x);
					
					if(this.elements[j-1].y + newElement.height > CloudTexture.HEIGHT)
						this.elements[j].y = - (CloudTexture.HEIGHT - this.elements[j - 1].y);
					trace("new", this.elements[j].x, this.elements[j].y);
					this.addChild(elements[j]);
				}
				
			}
			
			this.width = CloudTexture.WIDTH;
			this.height = CloudTexture.HEIGHT;
		}
		
	}

}