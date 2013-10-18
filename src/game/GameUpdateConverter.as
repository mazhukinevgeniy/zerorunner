package game 
{
	import data.StatusReporter;
	import data.viewers.GameConfig;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	final internal class GameUpdateConverter
	{
		private var flow:IUpdateDispatcher;
		private var config:GameConfig;
		
		public function GameUpdateConverter(flow:IUpdateDispatcher, config:GameConfig) 
		{
			this.flow = flow;
			this.config = config;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
		}
		
		
		update function newGame():void
		{
			this.flow.dispatchUpdate(Update.prerestore, this.config);
			this.flow.dispatchUpdate(Update.restore);
		}
		
		
		
	}

}