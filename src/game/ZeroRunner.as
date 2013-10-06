package game 
{
	import game.core.GameFoundations;
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
			this.save = new GameSave(flow);
			
			new GameUpdateConverter(flow, this.save);
			
			this.atlas = assets.getTextureAtlas("gameAtlas");
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.setGameContainer);
			flow.addUpdateListener(Update.freeFrame);
		}
		
		update function setGameContainer(root:Sprite):void
		{
			var foundations:GameFoundations = new GameFoundations
					(this.flow, this.save, this.atlas, root);
			
			new UIExtendsions(foundations);
		}
		
		update function freeFrame(key:int):void
		{
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				if (this.save.localGoal == Game.LIGHT_A_BEACON)
					if (this.save.getBeacon(this.save.level) != Game.NO_BEACON)
					{
						if (this.save.level == Game.LEVELS_PER_RUN)
							this.flow.dispatchUpdate(Update.tellGameWon);
						else
							this.flow.dispatchUpdate(Update.tellRoundWon);
						
						this.save.advanceLevel();
					}
			}
		}
	}

}