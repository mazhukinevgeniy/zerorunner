package data.structs 
{
	
	public class GameConfig 
	{
		
		public function GameConfig(...) 
		{
			
		}
		
		public function get mapWidth():int { return this.localSave.data.gameCurrentWidth; }
		public function get sectorWidth():int { return this.localSave.data.gameSectorWidth; }
		
		public function get numberOfJunks():int { return this.localSave.data.gameCurrentJunks; }
		
		public function get localGoal():int { return this.localSave.data.gameCurrentGoal; };
		
		
		
		
		
		
		
		
		
		
	}

}