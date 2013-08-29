package game 
{
	import game.hud.UIExtendsions;
	import game.utils.GameFoundations;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.templates.UpdateGameBase;
	import utils.updates.update;
	
	public class ZeroRunner
	{
		private var flow:UpdateGameBase;
		private var save:GameSave;
		
		private var atlas:TextureAtlas;
		
		public function ZeroRunner(assets:AssetManager) 
		{			
			this.flow = new UpdateGameBase();
			this.save = new GameSave();
			
			this.atlas = assets.getTextureAtlas("gameAtlas");
			
			this.flow.workWithUpdateListener(this);
			this.flow.addUpdateListener(Update.setGameContainer);
		}
		
		update function setGameContainer(root:Sprite):void
		{
			var foundations:GameFoundations = new GameFoundations
					(this.flow, this.save, this.atlas, root);
			
			new UIExtendsions(foundations);
		}
	}

}