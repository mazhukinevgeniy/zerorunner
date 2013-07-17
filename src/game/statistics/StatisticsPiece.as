package game.statistics 
{
	
	public class StatisticsPiece 
	{
		public var entry:Vector.<String>;
		public var length:int;
		
		public function StatisticsPiece(vector:Vector.<String>) 
		{
			this.entry = vector;
			
			this.length = vector.length;
		}
		
	}

}