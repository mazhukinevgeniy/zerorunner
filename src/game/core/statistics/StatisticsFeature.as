package game.core.statistics 
{
	import utils.updates.IUpdateDispatcher;
	
	public class StatisticsFeature 
	{
		
		public function StatisticsFeature(flow:IUpdateDispatcher) 
		{
			new StatisticsView(flow);
		}
		
		
	}

}