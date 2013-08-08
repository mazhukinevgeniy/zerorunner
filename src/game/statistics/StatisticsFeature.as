package game.statistics 
{
	import utils.updates.IUpdateDispatcher;
	
	public class StatisticsFeature 
	{
		public static const emitStatistics:String = "emitStatistics";
		
		public static const showStatistics:String = "showStatistics";
		public static const hideStatistics:String = "hideStatistics";
		
		public function StatisticsFeature(flow:IUpdateDispatcher) 
		{
			new StatisticsView(flow);
			new TemporaryEmitter(flow);
			new DoubleTemporaryEmitter(flow);
		}
		
		
	}

}