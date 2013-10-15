package game.world.clouds 
{
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.system.LoaderContext;
	import starling.display.Sprite;
	import flash.net.URLRequest;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class CloudPiece extends Sprite
	{
		private static const PATH_BY_TEXTURE:String = "../res/assets/textures/atlases/sprites/unimplemented.png";
		
		private static const NUMBER_OF_CELLS_IN_WIDTH:int = 16;
		private static const NUMBER_OF_CELLS_IN_HEIGHT:int = 12;
		
		private var widthCloudPiece:Number;
		private var heightCloudPiece:Number;
		
		public function CloudPiece(width:Number, height:Number) 
		{
			this.widthCloudPiece = width;
			this.heightCloudPiece = height;
			
			var loader:Loader = new Loader();
			var context:LoaderContext = new LoaderContext();
			context.checkPolicyFile = true; 
			
			var urlRequest:URLRequest = new URLRequest(CloudPiece.PATH_BY_TEXTURE);
			loader.load(urlRequest, context);

			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoaded);
		}
		
		private function imgLoaded(event:Event):void
		{	
			var content:DisplayObject = event.target.content;
			var bmpData:BitmapData = new BitmapData(this.widthCloudPiece, this.heightCloudPiece, true, 0x00FFFFFF);
			bmpData.draw(content);
			 
			var texture:Texture = Texture.fromBitmapData(bmpData);
			var image:Image = new Image(texture);
			this.addChild(image);
		}
		
	}

}