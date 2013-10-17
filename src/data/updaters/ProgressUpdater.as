package data.updaters 
{
	import data.viewers.GameConfig;
	import flash.utils.Proxy;
	import game.core.metric.ICoordinated;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ProgressUpdater 
	{
		private var save:Proxy;
		private var flow:IUpdateDispatcher;
		
		private var config:GameConfig;
		
		public function ProgressUpdater(flow:IUpdateDispatcher, save:Proxy, config:GameConfig) 
		{
			this.save = save;
			this.flow = flow;
			
			this.config = config;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.smallBeaconTurnedOn);
			flow.addUpdateListener(Update.technicUnlocked);
			flow.addUpdateListener(Update.numberedFrame);
		}
		
		update function smallBeaconTurnedOn():void
		{
			this.save["beacon" + String(this.save["level"])] = Game.BEACON;
		}
		
		update function technicUnlocked(place:ICoordinated):void
		{
			this.save["activeDroids"]++;
		}
		
		//TODO: it's not the place to do it, is it?
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				if (this.save["goal"] == Game.LIGHT_A_BEACON)
					if (this.save["beacon" + String(this.save["level"])] != Game.NO_BEACON)
					{
						if (this.save["level"] == Game.LEVEL_CAP)
						{
							this.flow.dispatchUpdate(Update.tellGameWon, this.config);
						}
						else
						{
							this.flow.dispatchUpdate(Update.tellRoundWon, this.config);
							
							this.save["level"] += 1;
							this.save["junks"] = 1;
						}
					}
			}
		}
	}

}