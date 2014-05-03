package game 
{
	import data.StatusReporter;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	final internal class GameUpdateConverter
	{
		private var flow:IUpdateDispatcher;
		
		public function GameUpdateConverter(flow:IUpdateDispatcher) 
		{
			this.flow = flow;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
		}
		
		
		update function newGame():void
		{
			this.flow.dispatchUpdate(Update.restore);
		}
		
		
		
	}

}