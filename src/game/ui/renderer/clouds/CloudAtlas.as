package game.ui.renderer.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	internal class CloudAtlas extends TextureAtlas
	{	
		
		public function CloudAtlas(cloudiness:int) 
		{
			const aXML:XML = 
				<atlas>
					<SubTexture name="texture1" x="0" y="0" width="1024" height="1024"/>
					<SubTexture name="texture2" x="1024" y="0" width="1024" height="1024"/>
					<SubTexture name="texture3" x="1024" y="1024" width="1024" height="1024"/>
					<SubTexture name="texture4" x="0" y="1024" width="1024" height="1024"/>
				</atlas>;
			
			super(this.createTexture(cloudiness), aXML);
		}
		
		private function createTexture(cloudiness:int):Texture
		{
			var container:Sprite = new Sprite();
			
			for (var i:int = 0; i < 4; ++i)
			{
				var bitmap:Bitmap = new Bitmap(new CloudBitmap(cloudiness))
				container.addChild(bitmap);
				
				bitmap.x = 1024 * (i % 2);
				bitmap.y = 1024 * int(i / 2);
			}
			
			var full:BitmapData = new BitmapData(2048, 2048, true, 0);
			full.draw(container);
			
			var texture:Texture = Texture.fromBitmapData(full);
			
			
			for (var j:int = 0; j < 4; j++)
			{
				var bm:Bitmap = container.getChildAt(j) as Bitmap;
				
				bm.bitmapData.dispose();
			}
			
			container.removeChildren();
			
			full.dispose();
			
			
			return texture;
		}
		
		override public function dispose():void
		{
			this.texture.base.dispose();
		}
	}

}