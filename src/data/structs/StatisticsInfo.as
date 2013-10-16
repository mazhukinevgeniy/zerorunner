package data.structs 
{
	
	public class StatisticsInfo 
	{
		private var _distance:int;
		
		public function StatisticsInfo(distance:int) 
		{
			this._distance = distance;
		}
		
		
		
		public function get totalDistance():int
		{
			return this._distance;
		}
	}

}