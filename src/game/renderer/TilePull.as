package game.renderer 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	internal class TilePull 
	{
		private var textures:Object;
		
		public function TilePull(assets:AssetManager) 
		{
			var atlas:TextureAtlas = assets.getTextureAtlas("scene");
			
			var titles:Vector.<String> = new < String > 
										   ["ground", 
											"ground_S", "ground_W", "ground_E", "ground_N",
											"ground_NE", "ground_NW", "ground_SE", "ground_SW",
											"stones1", "stones2", "stones3",
											"lava",
											"lava_S", "lava_W", "lava_E", "lava_N",
											"lava_NE", "lava_NW", "lava_SE", "lava_SW"];
			
			this.textures = new Object();
			
			var length:int = titles.length;
			for (var i:int = 0; i < length; i++)
			{
				this.textures[titles[i]] = new Image(atlas.getTexture(titles[i]));
			}
		}
		
		public function getImage(title:String):Image
		{
			return this.textures[title]; //TODO: optimize by using vector and int keys
		}
	}

}