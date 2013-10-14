package data.old stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff stuff 
{
	import game.core.metric.ICoordinated;
	import utils.SaveBase;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class GameSave extends SaveBase implements IGame
	{
		
		private var defaultValues:Object = 
		{
			gameCurrentWidth: 1,
			gameSectorWidth: 10,
			gameCurrentLevel: 1,
			gameCurrentJunks: 2,
			gameCurrentGoal: Game.LIGHT_A_BEACON,
			gameActiveDroids: 0
		}
		
		public function GameSave(flow:IUpdateDispatcher) 
		{
			for (var i:int = 0; i < Game.LEVELS_PER_RUN; i++)
				this.defaultValues["beaconProgress" + String(i + 1)] = Game.NO_BEACON;
			
			super();
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.prerestore);
			flow.addUpdateListener(Update.resetProgress);
			flow.addUpdateListener(Update.technicUnlocked);
			flow.addUpdateListener(Update.smallBeaconTurnedOn);
		}
		
		override protected function checkLocalSave():void
		{
			for (var value:String in this.defaultValues)
			{
				if (!this.localSave.data[value])
					this.localSave.data[value] = this.defaultValues[value];
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		internal function advanceLevel():void
		{
			if (this.level == Game.LEVELS_PER_RUN)
				this.update::resetProgress();
			else
				this.localSave.data.gameCurrentLevel += 1;
		}
	}

}