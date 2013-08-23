package game 
{
	import game.hud.UIExtendsions;
	import game.utils.GameFoundations;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.templates.UpdateGameBase;
	
	public class ZeroRunner extends UpdateGameBase implements IGame
	{
		public static const flowName:String = "Game Flow";
		
		
		private var atlas:TextureAtlas;
		
		public function ZeroRunner(assets:AssetManager) 
		{			
			super(ZeroRunner.flowName);
			
			this.atlas = assets.getTextureAtlas("gameAtlas");
		}
		
		override protected function initializeFeatures():void
		{
			this.displayRoot.stage.color = 0;
			
			var foundations:GameFoundations = new GameFoundations
					(this, this.atlas, this.displayRoot);
			
			new UIExtendsions(this);
		}
		
		public function getMapWidth():int
		{
			return 50;
			//TODO: must work with 240;
		}
	}

}