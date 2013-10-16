package data 
{
	import game.core.metric.ICoordinated;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class ProgressUpdater 
	{
		private var save:SharedObjectManager;
		
		public function ProgressUpdater(flow:IUpdateDispatcher, save:SharedObjectManager) 
		{
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.smallBeaconTurnedOn);
			flow.addUpdateListener(Update.technicUnlocked);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.resetProgress);
		}
		
		update function smallBeaconTurnedOn():void
		{
			this.save["beacon" + String(this.save.level)] = Game.BEACON;
		}
		
		update function technicUnlocked(place:ICoordinated):void
		{
			this.save.activeDroids++;
		}
		
		update function prerestore():void
		{
			//for example
			
			this.save.activeDroids = 0;
			this.save.junks = this.save.level * 2;
		}
		
		update function resetProgress():void
		{
			for (var value:String in Defaults.progressDefaults)
				this.save[value] = Defaults.progressDefaults[value];
		}
		/*
		internal function advanceLevel():void
		{
			if (this.level == Game.LEVELS_PER_RUN)
				this.update::resetProgress();
			else
				this.localSave.data.gameCurrentLevel += 1;
		}*/
		//TODO: reimplement somehow somewhere
	}

}