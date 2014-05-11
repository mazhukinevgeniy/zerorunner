package view.game.renderer.clouds 
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
			
			aXML.SubTexture[0].@width = View.CLOUD_WIDTH;
			aXML.SubTexture[0].@height = View.CLOUD_WIDTH;
			
			aXML.SubTexture[1].@x = View.CLOUD_WIDTH;
			aXML.SubTexture[1].@width = View.CLOUD_WIDTH;
			aXML.SubTexture[1].@height = View.CLOUD_WIDTH;
			
			aXML.SubTexture[2].@x = View.CLOUD_WIDTH;
			aXML.SubTexture[2].@y = View.CLOUD_WIDTH;
			aXML.SubTexture[2].@width = View.CLOUD_WIDTH;
			aXML.SubTexture[2].@height = View.CLOUD_WIDTH;
			
			aXML.SubTexture[3].@y = View.CLOUD_WIDTH;
			aXML.SubTexture[3].@width = View.CLOUD_WIDTH;
			aXML.SubTexture[3].@height = View.CLOUD_WIDTH;
			
			
			super(this.createTexture(cloudiness), aXML);
			
			if (View.CELL_HEIGHT != View.CELL_WIDTH ||
				View.CELL_HEIGHT * Game.MAP_WIDTH % View.CLOUD_WIDTH != 0)
				throw new Error("assumption is not fulfilled");
		}
		
		private function createTexture(cloudiness:int):Texture
		{
			var container:Sprite = new Sprite();
			
			for (var i:int = 0; i < 4; ++i)
			{
				var bitmap:Bitmap = new Bitmap(new CloudBitmap(cloudiness))
				container.addChild(bitmap);
				
				bitmap.x = View.CLOUD_WIDTH * (i % 2);
				bitmap.y = View.CLOUD_WIDTH * int(i / 2);
			}
			
			var full:BitmapData = new BitmapData(View.CLOUD_WIDTH * 2, View.CLOUD_WIDTH * 2, true, 0);
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