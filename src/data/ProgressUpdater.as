package data 
{
	
	internal class ProgressUpdater 
	{
		
		public function ProgressUpdater() 
		{
			
		}
		
		update function smallBeaconTurnedOn():void
		{
			this.localSave.data["beaconProgress" + String(this.level)] = Game.BEACON;
		}
		
		update function technicUnlocked(place:ICoordinated):void
		{
			this.localSave.data.gameActiveDroids++;
		}
		
		update function prerestore():void
		{
			//for example
			
			this.localSave.data.gameActiveDroids = 0;
			this.localSave.data.gameCurrentJunks = this.level * 2;
		}
		
		update function resetProgress():void
		{
			for (var value:String in this.defaultValues)
				this.localSave.data[value] = this.defaultValues[value];
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