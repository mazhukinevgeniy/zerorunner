package game.world.renderer 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	internal class TilePull 
	{
		private var textures:Object;
		
		public function TilePull(atlas:TextureAtlas) 
		{
			var titles:Vector.<String> = new < String > 
										   ["ground", "S", "W", "E", "N",
											"NE", "NW", "SE", "SW",
											"stones1", "stones2", "stones3",
											"bottom", "left", "top", "right", "lava",
											"1", "3", "7", "9"];
			
			this.textures = new Object();
			
			var length:int = titles.length;
			for (var i:int = 0; i < length; i++)
			{
				this.textures[titles[i]] = new Image(atlas.getTexture(titles[i]));
			}
		}
		
		public function getImage(title:String):Image
		{
			return this.textures[title];
		}
	}

}