package chaotic.scene 
{
	import starling.display.Image;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	internal class TilePull 
	{
		private var textures:Vector.<Texture>;
		private var pull:Vector.<Vector.<Image>>;
		
		public function TilePull(assets:AssetManager) 
		{
			var atlas:TextureAtlas = assets.getTextureAtlas("gameAtlas");
			
			
			this.textures = new Vector.<Texture>(SceneFeature.NUMBER_OF_DIFFERENT_SPRITES, true);
			
			this.pull = new Vector.<Vector.<Image>>(SceneFeature.NUMBER_OF_DIFFERENT_SPRITES, true);
			
			for (var i:int = 0; i < SceneFeature.NUMBER_OF_DIFFERENT_SPRITES; i++)
			{
				this.textures[i] = atlas.getTexture("scene" + i);
				
				this.pull[i] = new Vector.<Image>();
			}
		}
		
		public function getImage(code:int):Image
		{
			var image:Image = this.pull[code].pop();
			
			if (image == null)
			{
				image = new SingleSceneTile(this.textures[code], code, this);
			}
			
			return image;
		}
		
		internal function useTile(item:SingleSceneTile, code:int):void
		{
			this.pull[code].push(item);
		}
	}

}