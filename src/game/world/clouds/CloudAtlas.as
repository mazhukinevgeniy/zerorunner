package game.world.clouds 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.printing.PrintJob;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	public class CloudAtlas extends TextureAtlas
	{	
		
		public function CloudAtlas(cloudiness:int) 
		{
			const aXML:XML = 
				<atlas>
					<SubTexture name="texture1" x="0" y="0" width="256" height="256"/>
					<SubTexture name="texture2" x="256" y="0" width="256" height="256"/>
					<SubTexture name="texture3" x="256" y="256" width="256" height="256"/>
					<SubTexture name="texture4" x="0" y="256" width="256" height="256"/>
				</atlas>;
			
			var container:Sprite = new Sprite();
			var bd:BitmapData = new CloudBitmap(cloudiness);
			
			for (var i:int = 0; i < 4; ++i)
			{
				var cpBd:BitmapData = bd.clone();
				var bitmap:Bitmap = new Bitmap(new CloudBitmap(cloudiness))
				container.addChild(bitmap);
				
				bitmap.x = 256 * (i % 2);
				bitmap.y = 256 * int(i / 2);
			}
			
			var full:BitmapData = new BitmapData(1024, 1024, true, 0);
			full.draw(container);
			
			super(Texture.fromBitmapData(full), aXML);
			
			//todo:remove the code below and every import
			
			var p:PrintJob = new PrintJob();
			
			p.start();
			
			var tmp:Sprite = new Sprite();
			tmp.addChild(new Bitmap(full));
			//tmp.scaleX = tmp.scaleY = 9 / 40;
			
			p.addPage(tmp);
			p.send();
		}
	}

}