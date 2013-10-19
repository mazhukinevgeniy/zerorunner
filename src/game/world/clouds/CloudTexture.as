package game.world.clouds 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	public class CloudTexture extends Sprite//Texture
	{
		private static const PATH_BY_TEXTURE:String = "../res/assets/textures/atlases/sprites/unimplemented.png";
		
		private var cloudiness:int;
		private var loader:Loader;
		
		public function CloudTexture(cloudiness:int) 
		{
			this.cloudiness = cloudiness;
			
			this.loader = new Loader();
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true; 
			
			var urlRequest:URLRequest = new URLRequest(CloudTexture.PATH_BY_TEXTURE);
			this.loader.load(urlRequest, context);

			this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoaded);
		}
		
		private function imgLoaded(event:Event):void
		{	
			var content:DisplayObject = event.target.content;
			
			this.generateTexture(content);
		}
		
		private function generateTexture(sprite:DisplayObject):void
		{
			var numberOfElements:int = int((Math.random() + 3) / 4 * this.cloudiness);
			var usedNumberOfElements:int;
			
			while (numberOfElements != 0)
			{
				usedNumberOfElements = numberOfElements;//int(Math.random() * usedNumberOfElements);
				numberOfElements -= usedNumberOfElements;
				
				new CloudPiece(usedNumberOfElements, sprite);
				
				var cloudPiece:DisplayObject = new CloudPiece(usedNumberOfElements, sprite);
				var bmpData:BitmapData = new BitmapData(cloudPiece.width, cloudPiece.height, true, 0x00FFFFFF);
				bmpData.draw(cloudPiece);
				 
				var texture:Texture = Texture.fromBitmapData(bmpData);
				var image:Image = new Image(texture);
				this.addChild(image);
			}
			
			
		}
		
	}

}