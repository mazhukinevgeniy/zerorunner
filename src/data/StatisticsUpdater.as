package data 
{
	import game.core.metric.DCellXY;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class StatisticsUpdater 
	{
		private var save:SharedObjectManager;
		
		public function StatisticsUpdater(flow:IUpdateDispatcher, save:SharedObjectManager) 
		{
			this.save = save;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.moveCenter);
		}
		
		update function moveCenter(change:DCellXY, delay:int):void
		{
			this.save.distance += change.length;
		}
		
	}

}