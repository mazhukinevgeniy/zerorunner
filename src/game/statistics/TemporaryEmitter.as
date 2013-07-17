package game.statistics 
{
	import chaotic.core.IUpdateDispatcher;
	
	internal class TemporaryEmitter 
	{
		private var flow:IUpdateDispatcher;
		
		public function TemporaryEmitter(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(StatisticsFeature.emitStatistics);
			
			
			this.flow = flow;
		}
		
		public function emitStatistics(requester:ITakeStatistics):void
		{
			 requester.takeStatistics(new StatisticsPiece(new < String > ["hey hey hey", "dinosaurs", "dinosours", "dinozurs", "dinosavr", "dinosourse"]));
		}
	}

}