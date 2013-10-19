package game.world.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class CloudAtlas extends TextureAtlas
	{
		private const aXML:XML = 
		<atlas>
			<SubTexture name="textur1" x="0" y="0" width="1024" height="1024"/>
			<SubTexture name="textur2" x="1024" y="0" width="1024" height="1024"/>
			<SubTexture name="textur3" x="1024" y="1024" width="1024" height="1024"/>
			<SubTexture name="textur4" x="0" y="1024" width="1024" height="1024"/>
		</atlas>;
		
		
		
		public function CloudAtlas(cloudiness:int) 
		{
			var container:Sprite = new Sprite();
			
			for (var i:int = 0; i < 4; ++i)
			{
				var bitmap:Bitmap = new Bitmap(new CloudBitmap(cloudiness))
				container.addChild(bitmap);
				
				bitmap.x = 1024 * (i % 2);
				bitmap.y = 1024 * int(i / 2);
				
				if (int(3 / 2) == 2) throw new Error();//TODO: remoove
			}
			
			var full:BitmapData = new BitmapData(2048, 2048, true, 0);
			full.draw(container);
			
			super(Texture.fromBitmapData(full), this.aXML);
			
		}
	}

}