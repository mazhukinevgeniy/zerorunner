package ui.achievements 
{
	public class AchievementsTable 
	{
		
		private var matrix:Vector.<Vector.<Boolean>>;
		
		public function AchievementsTable() 
		{
			this.matrix = new Vector.<Vector.<Boolean>>;
		}
		
		public function getCell(x:int, y:int):Boolean
		{
			return this.matrix[x][y];
		}
		
		public function setCell(x:int, y:int):void
		{
			this.matrix[x][y] = true;
		}
	}

}