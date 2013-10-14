package game 
{
	import data.structs.GameConfig;
	import game.core.GameFoundations;
	import game.hud.UIExtendsions;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.utils.AssetManager;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ZeroRunner
	{
		private var flow:IUpdateDispatcher;
		
		private var config:GameConfig;
		
		
		public function ZeroRunner(flow:IUpdateDispatcher, assets:AssetManager, root:Sprite) 
		{
			this.flow = flow;
			
			new GameUpdateConverter(flow);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.numberedFrame);
			
			var foundations:GameFoundations = new GameFoundations
					(this.flow, assets, root);
			
			new UIExtendsions(foundations);
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.config = config;
			//TODO: check if it would wind up unused
		}
		
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				if (this.config.goal == Game.LIGHT_A_BEACON)
					if (this.save.getBeacon(this.save.level) != Game.NO_BEACON)
					{
						if (this.save.level == Game.LEVELS_PER_RUN)
							this.flow.dispatchUpdate(Update.tellGameWon);
						else
							this.flow.dispatchUpdate(Update.tellRoundWon);
						
						//this.save.advanceLevel();
						//TODO: advance level somehow else (see "tellGameWon" etc)
					}
			}
		}
	}

}