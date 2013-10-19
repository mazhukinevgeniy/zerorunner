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
		internal static const WIDTH:Number = 512;
		internal static const HEIGHT:Number = 512;
		
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
			var numberOfElements:int = int(this.cloudiness * (Math.random() + 3) / 4);
			var alpha:Number = this.cloudiness * (Math.random() + 1) / 500 + 1/4;
			
			var cloudPiece:DisplayObject = new CloudPiece(numberOfElements, baseCloud);
			var bmpData:BitmapData = new BitmapData(cloudPiece.width, cloudPiece.height, true, 0x00FFFFFF);
			bmpData.draw(cloudPiece);
			 
			var texture:Texture = Texture.fromBitmapData(bmpData);		
			
			var image:Image = new Image(texture);
			image.alpha = alpha;
			this.addChild(image);
			
			
		}
		
	}

}