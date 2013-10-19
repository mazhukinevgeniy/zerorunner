package game.world.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	public class CloudPiece extends Sprite
	{
		private var widthCloudPiece:Number;
		private var heightCloudPiece:Number;
		
		private var elements:Vector.<Bitmap>;
		private var dataBaseCloud:BitmapData;
		
		public function CloudPiece(numberOfElements:int, baseCloud:Bitmap)
		{
			var size:Number = Math.sqrt(numberOfElements);
			
			this.elements = new Vector.<Bitmap>;
			this.dataBaseCloud = baseCloud.bitmapData;
			
			this.widthCloudPiece = (size * baseCloud.width * 4) / 3;
			this.heightCloudPiece = (size * baseCloud.height * 4) / 3;
			
			for (var i:int = 0; i < numberOfElements; ++i)
			{
				var newElement:Bitmap = new Bitmap(this.dataBaseCloud.clone())
				
				elements.push(newElement);
				elements[i].x = Math.random() * (this.widthCloudPiece - newElement.width);
				elements[i].y = Math.random() * (this.heightCloudPiece - newElement.height);
				this.addChild(elements[i]);
			}
			
			this.width = this.widthCloudPiece;
			this.height = this.heightCloudPiece;
		}
		
	}

}