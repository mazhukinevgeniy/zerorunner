package game 
{
	import data.StatusReporter;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	final internal class GameUpdateConverter
	{
		private var flow:IUpdateDispatcher;
		private var status:StatusReporter;
		
		public function GameUpdateConverter(flow:IUpdateDispatcher, data:StatusReporter) 
		{
			this.flow = flow;
			this.status = data;
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.newGame);
			flow.addUpdateListener(Update.tellRoundLost);
			flow.addUpdateListener(Update.tellGameWon);
			flow.addUpdateListener(Update.tellRoundWon);
		}
		
		
		update function newGame():void
		{
			this.flow.dispatchUpdate(Update.prerestore, this.status.currentConfig);
			this.flow.dispatchUpdate(Update.restore);
		}
		
		
		
		update function tellGameWon():void { this.flow.dispatchUpdate(Update.gameStopped); }
		update function tellRoundWon():void { this.flow.dispatchUpdate(Update.gameStopped);	}
		update function tellRoundLost():void { this.flow.dispatchUpdate(Update.gameStopped); }
		
	}

}