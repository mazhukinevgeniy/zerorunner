package game.scene 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	internal class TilePull 
	{
		//private var textures:Vector.<Texture>;
		
		private var textures:Object;
		
		private var pull:Vector.<Vector.<Image>>;
		private var inUse:Vector.<Vector.<Image>>;
		
		public function TilePull(assets:AssetManager) 
		{
			var atlas:TextureAtlas = assets.getTextureAtlas("gameAtlas");
			
			
			//this.textures = new Vector.<Texture>(SceneFeature.NUMBER_OF_DIFFERENT_SPRITES, true);
			
			//this.pull = new Vector.<Vector.<Image>>(SceneFeature.NUMBER_OF_DIFFERENT_SPRITES, true);
			//this.inUse = new Vector.<Vector.<Image>>(SceneFeature.NUMBER_OF_DIFFERENT_SPRITES, true);
			
			//for (var i:int = 0; i < SceneFeature.NUMBER_OF_DIFFERENT_SPRITES; i++)
			//{
			//	this.textures[i] = atlas.getTexture("scene" + i);
				
			//	this.pull[i] = new Vector.<Image>();
			//	this.inUse[i] = new Vector.<Image>();
			//}
			
			this.textures = new Object();
			this.textures["ground"] = atlas.getTexture("ground");
			this.textures["S"] = atlas.getTexture("S");
			this.textures["W"] = atlas.getTexture("W");
			this.textures["E"] = atlas.getTexture("E");
			this.textures["N"] = atlas.getTexture("N");
			this.textures["NE"] = atlas.getTexture("NE");
			this.textures["NW"] = atlas.getTexture("NW");
			this.textures["SE"] = atlas.getTexture("SE");
			this.textures["SW"] = atlas.getTexture("SW");
			this.textures["stones1"] = atlas.getTexture("stones1");
			this.textures["stones2"] = atlas.getTexture("stones2");
			this.textures["stones3"] = atlas.getTexture("stones3");
		}
		
		public function getImage(title:String):Image
		{
			var image:Image;// = this.pull[code].pop();
			//
			//if (image == null)
			//{
				image = new Image(this.textures[title]);
			//}
			//
			//this.inUse[code].push(image);
			//
			return image;
		}
		
		public function nothingIsInUse():void
		{
			var image:Image;
			
			//for (var i:int = 0; i < SceneFeature.NUMBER_OF_DIFFERENT_SPRITES; i++)
			//{
			//	image = this.inUse[i].pop();
			//	
			//	while (image)
				{
			//		this.pull[i].push(image);
			//		image = this.inUse[i].pop();
				}
			//}
		}
	}

}