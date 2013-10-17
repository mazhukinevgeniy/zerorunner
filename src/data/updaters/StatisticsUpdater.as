package data.updaters 
{
	import flash.utils.Proxy;
	import game.core.metric.DCellXY;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class StatisticsUpdater 
	{
		private var save:Proxy;
		
		public function StatisticsUpdater(flow:IUpdateDispatcher, save:Proxy) 
		{
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.moveCenter);
		}
		
		update function moveCenter(change:DCellXY, delay:int):void
		{
			this.save["distance"] += change.length;
		}
		
	}

}