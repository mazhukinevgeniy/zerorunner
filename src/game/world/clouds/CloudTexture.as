package game.world.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class CloudTexture extends Sprite//Texture
	{
		[Embed(source="../../../../res/assets/textures/atlases/sprites/unimplemented.png")]
		private static const BaseCloud:Class;
		
		private var cloudiness:int;
		
		public function CloudTexture(cloudiness:int) 
		{
			this.cloudiness = cloudiness;
			
			var baseCloud:Bitmap = new BaseCloud();
			this.generateTexture(baseCloud);
			
		}
		
		private function generateTexture(baseCloud:Bitmap):void
		{
			var numberOfElements:int = int((Math.random() + 3) / 4 * this.cloudiness);
			var usedNumberOfElements:int;
			
			while (numberOfElements != 0)
			{
				usedNumberOfElements = numberOfElements;//int(Math.random() * usedNumberOfElements);
				numberOfElements -= usedNumberOfElements;
				
				new CloudPiece(usedNumberOfElements, baseCloud);
				
				var cloudPiece:DisplayObject = new CloudPiece(usedNumberOfElements, baseCloud);
				var bmpData:BitmapData = new BitmapData(cloudPiece.width, cloudPiece.height, true, 0x00FFFFFF);
				bmpData.draw(cloudPiece);
				 
				var texture:Texture = Texture.fromBitmapData(bmpData);
				var image:Image = new Image(texture);
				this.addChild(image);
			}
			
			
		}
		
	}

}