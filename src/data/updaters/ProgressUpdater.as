package data.updaters 
{
	import data.Defaults;
	import data.viewers.GameConfig;
	import flash.utils.Proxy;
	import game.core.metric.ICoordinated;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class ProgressUpdater 
	{
		private var save:Proxy;
		private var flow:IUpdateDispatcher;
		
		public function ProgressUpdater(flow:IUpdateDispatcher, save:Proxy) 
		{
			this.save = save;
			this.flow = flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.smallBeaconTurnedOn);
			flow.addUpdateListener(Update.technicUnlocked);
			flow.addUpdateListener(Update.numberedFrame);
			flow.addUpdateListener(Update.resetProgress);
		}
		
		update function resetProgress():void
		{
			for (var value:String in Defaults.progressDefaults)
				this.save[value] = Defaults.progressDefaults[value];
		}
		
		update function smallBeaconTurnedOn():void
		{
			this.save["beacon" + String(this.save["level"])] = Game.BEACON;
		}
		
		update function technicUnlocked(place:ICoordinated):void
		{
			this.save["activeDroids"]++;
		}
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
				if (this.save["goal"] == Game.LIGHT_A_BEACON)
					if (this.save["beacon" + String(this.save["level"])] != Game.NO_BEACON)
					{
						this.flow.dispatchUpdate(Update.gameFinished, Game.WON);
						this.save["level"]++;
						this.save["cloudiness"] += 2;
						this.save["junks"] = 1;
						
						if (this.save["level"] > Game.LEVEL_CAP)
							this.update::resetProgress();
					}
		}
		
	}

}