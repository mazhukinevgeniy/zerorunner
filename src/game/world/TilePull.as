package game.world 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	internal class TilePull 
	{
		private var titles:Vector.<String>;
		
		private var textures:Object;
		
		private var pull:Object;
		private var inUse:Object;
		
		public function TilePull(assets:AssetManager) 
		{
			var atlas:TextureAtlas = assets.getTextureAtlas("gameAtlas");
			
			this.titles = new < String > ["ground", "S", "W", "E", "N",
										 "NE", "NW", "SE", "SW",
										 "stones1", "stones2", "stones3"];
			
			this.textures = new Object();
			this.pull = new Object();
			this.inUse = new Object();
			
			var length:int = this.titles.length;
			for (var i:int = 0; i < length; i++)
			{
				this.textures[this.titles[i]] = atlas.getTexture(this.titles[i]);
				
				this.pull[this.titles[i]] = new Vector.<Image>();
				this.inUse[this.titles[i]] = new Vector.<Image>();
			}
		}
		
		public function getImage(title:String):Image
		{
			var image:Image = this.pull[title].pop();
			
			if (image == null)
			{
				image = new Image(this.textures[title]);
			}
			
			this.inUse[title].push(image);
			
			return image;
		}
		
		public function nothingIsInUse():void
		{
			var image:Image;
			
			var length:int = this.titles.length;
			
			for (var i:int = 0; i < length; i++)
			{
				var title:String = this.titles[i];
				
				var used:Vector.<Image> = this.inUse[title];
				var free:Vector.<Image> = this.pull[title];
				
				image = used.pop();
				
				while (image)
				{
					free.push(image);
					image = used.pop();
				}
			}
		}
	}

}