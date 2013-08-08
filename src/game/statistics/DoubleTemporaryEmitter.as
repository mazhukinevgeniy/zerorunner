package game.statistics 
{
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class DoubleTemporaryEmitter 
	{
		private var flow:IUpdateDispatcher;
		
		public function DoubleTemporaryEmitter(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(StatisticsFeature.emitStatistics);
			
			
			this.flow = flow;
		}
		
		update function emitStatistics(requester:ITakeStatistics):void
		{
			requester.takeStatistics(new StatisticsPiece(new < String > ["hey hey hey", "dinosaurs", "hey hey", "dinozurs", "hey hey hey", "dinosourse"], "testing"));
		}
	}

}