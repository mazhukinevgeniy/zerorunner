package game 
{
	import game.core.GameFoundations;
	import game.hud.UIExtendsions;
	import game.utils.GameUpdateConverter;
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
			flow.addUpdateListener(Update.gameOver);
			flow.addUpdateListener(Update.gameWon);
			flow.addUpdateListener(Update.reparametrize);
		}
		
		update function setGameContainer(root:Sprite):void
		{
			var foundations:GameFoundations = new GameFoundations
					(this.flow, this.save, this.atlas, root);
			
			new UIExtendsions(foundations);
		}
		
		update function reparametrize(params:IGame):void
		{
			this.save.mapWidth = params.mapWidth;
		}
		
		update function gameOver():void
		{
			this.flow.dispatchUpdate(Update.gameStopped);
		}
		
		update function gameWon():void
		{
			this.flow.dispatchUpdate(Update.gameStopped);
		}
	}

}