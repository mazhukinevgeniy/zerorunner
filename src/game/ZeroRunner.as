package game 
{
	import game.core.GameFoundations;
	import game.data.GameSave;
	import game.hud.UIExtendsions;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ZeroRunner
	{
		private var flow:IUpdateDispatcher;
		private var save:GameSave;
		
		private var atlas:TextureAtlas;
		
		public function ZeroRunner(flow:IUpdateDispatcher, assets:AssetManager) 
		{
			this.flow = flow;
			this.save = new GameSave();
			
			new GameUpdateConverter(flow, this.save);
			
			this.atlas = assets.getTextureAtlas("gameAtlas");
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.setGameContainer);
		}
		
		update function setGameContainer(root:Sprite):void
		{
			var foundations:GameFoundations = new GameFoundations
					(this.flow, this.save, this.atlas, root);
			
			new UIExtendsions(foundations);
		}
		
	}

}