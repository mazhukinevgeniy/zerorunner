package data.structs 
{
	
	public class ProgressInfo 
	{
		
		public function ProgressInfo() 
		{
			
		}
		
		
		/**
		 * Please note: level must be natural (i.e. it's an integer > 0)
		 */
		public function beacon(level:int):int
		{
			return this.localSave.data["beaconProgress" + String(level)];
		}
		
		public function get level():int { return this.localSave.data.gameCurrentLevel; }
		public function get numberOfDroids():int { return this.localSave.data.gameActiveDroids; }
	}

}