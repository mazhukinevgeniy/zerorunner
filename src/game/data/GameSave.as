package game.data 
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
			gameCurrentLevel: 1,
			gameCurrentJunks: 2,
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
			
			if (!this.localSave.data.beaconProgress)
			{
				this.localSave.data.beaconProgress = new Array();
			}
		}
		
		
		public function get level():int { return this.localSave.data.gameCurrentLevel; }
		public function get numberOfDroids():int { return this.localSave.data.gameActiveDroids; }
		
		public function get mapWidth():int { return this.localSave.data.gameCurrentWidth; }
		public function get numberOfJunks():int { return this.localSave.data.gameCurrentJunks; }
		
		/**
		 * Please note: level must be natural (i.e. it's an integer > 0)
		 */
		public function getBeacon(level:int):int
		{
			return this.localSave.data["beaconProgress" + String(level)];
		}
		
		
		
		update function smallBeaconTurnedOn():void
		{
			this.localSave.data["beaconProgress" + String(this.level)] = Game.BEACON;
			
			/*
			
			if (this.save.level == Game.LEVELS_PER_RUN)
				this.flow.dispatchUpdate(Update.tellGameWon);
			else
				this.flow.dispatchUpdate(Update.tellRoundWon);
				
			this.flow.dispatchUpdate(Update.gameStopped);
			*/
				//TODO: check somewhere else if the game is finished
		}
		
		update function technicUnlocked(place:ICoordinated):void
		{
			this.localSave.data.gameActiveDroids++;
		}
		
		update function prerestore():void
		{
			//TODO: advance level before; when prerestoring, modify every other parameter
		}
		
		update function resetProgress():void
		{
			for (var value:String in this.defaultValues)
				this.localSave.data[value] = this.defaultValues[value];
		}
		
	}

}