package game 
{
	import game.core.GameFoundations;
	import game.data.GameSave;
	import game.data.LevelConfiguration;
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
			new GameUpdateConverter(flow);
			
			this.flow = flow;
			this.save = new GameSave();
			
			this.atlas = assets.getTextureAtlas("gameAtlas");
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.setGameContainer);
			flow.addUpdateListener(Update.gameWon);
			flow.addUpdateListener(Update.resetProgress);
		}
		
		update function setGameContainer(root:Sprite):void
		{
			var foundations:GameFoundations = new GameFoundations
					(this.flow, this.save, this.atlas, root);
			
			new UIExtendsions(foundations);
		}
		
		update function resetProgress():void
		{
			this.applyConfiguration(new LevelConfiguration(null));
		}
		
		update function gameWon():void
		{
			this.applyConfiguration(new LevelConfiguration(this.save));
		}
		
		private function applyConfiguration(params:LevelConfiguration):void
		{
			this.save.mapWidth = params.mapWidth;
			this.save.level = params.level;
		}
	}

}