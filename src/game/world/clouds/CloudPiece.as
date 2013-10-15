package game.world.clouds 
{
	import flash.display.Loader;
	import flash.events.Event;
	import starling.display.Sprite;
	import flash.net.URLRequest;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class CloudPiece extends Sprite
	{
		import flash.display.BitmapData;
		import flash.display.Shape;
		import flash.filters.DropShadowFilter;
		import starling.utils.Color;
		
		private var ldr:Loader;
		
		public function CloudPiece() 
		{
			//var shape:Shape = new Shape();
			
			/*shape.graphics.beginFill(Color.MAROON);
			shape.graphics.drawCircle(50, 50, 30);
			shape.graphics.endFill();
			shape.filters = [ new DropShadowFilter() ];*/
			
			/*var rect:Shape = new Shape();
			rect.graphics.beginFill(0xFFFFFF);
			rect.graphics.drawRect(0, 0, 100, 100);
			rect.graphics.endFill();
			this.sprite = new flash.display.Sprite();
			this.sprite.addChild(rect);
			*/
			ldr = new Loader();
			//ldr.mask = rect;*/
			
			var url:String = "../res/assets/textures/atlases/sprites/unimplemented.png";
			var urlReq:URLRequest = new URLRequest(url);
			ldr.load(urlReq);

			ldr.contentLoaderInfo.addEventListener(Event.COMPLETE, imgLoaded);
		}
		
		private function imgLoaded(event:Event):void
		{
			
			
			var bmpData:BitmapData = new BitmapData(100, 100, true, 0xFFFFFFFF);
			bmpData.draw(ldr.content);
			 
			//var texture:Texture = Texture.fromColor(100, 100, 0x50654321);
			var texture:Texture = Texture.fromBitmapData(bmpData);
			var image:Image = new Image(texture);
			addChild(image);
		}
		
	}

}