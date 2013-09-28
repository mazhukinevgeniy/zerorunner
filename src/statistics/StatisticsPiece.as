package statistics 
{
	
	public class StatisticsPiece 
	{
		public var entry:Vector.<String>;
		public var length:int;
		public var title:String;
		
		public function StatisticsPiece(vector:Vector.<String>, title:String = "default title") 
		{
			this.entry = vector;
			this.title = title;
			
			this.length = vector.length;
		}
		
	}

}