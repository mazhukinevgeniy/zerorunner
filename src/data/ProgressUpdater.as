package data 
{
	import data.structs.GameConfig;
	import game.core.metric.ICoordinated;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class ProgressUpdater 
	{
		private var save:SharedObjectManager;
		private var flow:IUpdateDispatcher;
		
		public function ProgressUpdater(flow:IUpdateDispatcher, save:SharedObjectManager) 
		{
			this.save = save;
			this.flow = flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.smallBeaconTurnedOn);
			flow.addUpdateListener(Update.technicUnlocked);
			flow.addUpdateListener(Update.resetProgress);
			flow.addUpdateListener(Update.numberedFrame);
		}
		
		update function smallBeaconTurnedOn():void
		{
			this.save["beacon" + String(this.save.level)] = Game.BEACON;
		}
		
		update function technicUnlocked(place:ICoordinated):void
		{
			this.save.activeDroids++;
		}
		
		update function resetProgress():void
		{
			for (var value:String in Defaults.progressDefaults)
				this.save[value] = Defaults.progressDefaults[value];
		}
		
		update function numberedFrame(key:int):void
		{
			if (key == Game.FRAME_TO_UNLOCK_ACHIEVEMENTS)
			{
				if (this.save.goal == Game.LIGHT_A_BEACON)
					if (this.save["beacon" + String(this.save.level)] != Game.NO_BEACON)
					{
						if (this.save.level == Game.LEVEL_CAP)
						{
							this.flow.dispatchUpdate(Update.tellGameWon);
							this.update::resetProgress();
						}
						else
						{
							this.flow.dispatchUpdate(Update.tellRoundWon);
							
							this.save.level += 1;
							this.save.activeDroids = 0; //TODO: check if we can change it
							this.save.junks = this.save.level * 2;
						}
					}
			}
		}
	}

}