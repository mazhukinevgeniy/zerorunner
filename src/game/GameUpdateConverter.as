package game 
{
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
			flow.addUpdateListener(Update.tellRoundLost);
			flow.addUpdateListener(Update.tellGameWon);
			flow.addUpdateListener(Update.tellRoundWon);
		}
		
		
		update function newGame():void
		{
			this.flow.dispatchUpdate(Update.prerestore);
			this.flow.dispatchUpdate(Update.restore);
		}
		
		
		
		update function tellGameWon():void { this.flow.dispatchUpdate(Update.gameStopped); }
		update function tellRoundWon():void { this.flow.dispatchUpdate(Update.gameStopped);	}
		update function tellRoundLost():void { this.flow.dispatchUpdate(Update.gameStopped); }
		
	}

}