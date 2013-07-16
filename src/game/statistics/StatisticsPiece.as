package game.statistics 
{
	
	public class StatisticsPiece 
	{
		internal var entry:Vector.<String>;
		internal var length:int;
		
		public function StatisticsPiece(vector:Vector.<String>) 
		{
			this.entry = vector;
			
			this.length = vector.length;
		}
		
	}

}