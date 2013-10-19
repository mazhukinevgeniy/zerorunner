package game.world.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;

	public class CloudTexture extends BitmapData
	{
		internal static const WIDTH:Number = 256;
		internal static const HEIGHT:Number = 256;
		
		[Embed(source="../../../../res/assets/textures/atlases/sprites/unimplemented.png")]
		private static const BaseCloud:Class;
		
		private var cloudiness:int;
		
		public function CloudTexture(cloudiness:int) 
		{
			this.cloudiness = cloudiness;
			
			super(CloudTexture.WIDTH, CloudTexture.HEIGHT, true, 0x00FFFFFF);
			
			var baseCloud:Bitmap = new BaseCloud();
			this.generateTexture(baseCloud);
			
			
		}
		
		private function generateTexture(baseCloud:Bitmap):void
		{
			var numberOfElements:int = int(this.cloudiness * (Math.random() + 3) / 4);
			
			
			var cloudPiece:DisplayObject = new CloudPiece(numberOfElements, baseCloud);
			this.draw(cloudPiece);
		}
		
	}

}