package data.structs 
{
	
	public class GameConfig 
	{
		
		public function GameConfig(...) 
		{
			
		}
		
		public function get level():int;
		
		function get mapWidth():int;
		function get sectorWidth():int;
		
		function get numberOfDroids():int;
		function get numberOfJunks():int;
		
		function get localGoal():int;
		
		
		function getBeacon(level:int):int;
	}

}