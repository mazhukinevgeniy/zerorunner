package data.structs 
{
	
	public class StatisticsInfo 
	{
		
		public function StatisticsInfo() 
		{
			
		}
		
		
		
		public function get totalDistance():int
		{
			return this.localSave.data.statistics.actors.lifetime.distance;
		}
	}

}