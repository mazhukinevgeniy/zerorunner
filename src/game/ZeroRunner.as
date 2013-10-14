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
		private var status:StatusReporter;
		
		private var _foundations:GameFoundations;
		
		
		public function ZeroRunner(flow:IUpdateDispatcher, status:StatusReporter, assets:AssetManager, root:Sprite) 
		{
			this.flow = flow;
			this.status = status;
			
			new GameUpdateConverter(flow);
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.numberedFrame);
			
			this._foundations = new GameFoundations(flow, status, assets, root);
			
			new UIExtendsions(foundations);
		}
		
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				var config:GameConfig = this.status.currentConfig;
				
				if (config.goal == Game.LIGHT_A_BEACON)
					if (config.beacon(config.level) != Game.NO_BEACON)
					{
						if (config.level == Game.LEVEL_CAP)
							this.flow.dispatchUpdate(Update.tellGameWon);
						else
							this.flow.dispatchUpdate(Update.tellRoundWon);
						
						//this.save.advanceLevel();
						//TODO: advance level somehow else (see "tellGameWon" etc)
					}
			}
		}
		
		public function get foundations():GameFoundations
		{
			return this._foundations;
		}
	}

}