package data 
{
	
	internal class StatisticsUpdater 
	{
		
		public function StatisticsUpdater() 
		{
			
		}
		
		update function moveCenter(change:DCellXY, delay:int):void
		{
			this.localSave.data.statistics.actors.lifetime.distance += change.length;
		}
		
	}

}