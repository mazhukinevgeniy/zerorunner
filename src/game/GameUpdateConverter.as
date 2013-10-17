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
			flow.addUpdateListener(Update.tellRoundLost);
			flow.addUpdateListener(Update.tellGameWon);
			flow.addUpdateListener(Update.tellRoundWon);
		}
		
		
		update function newGame():void
		{
			this.flow.dispatchUpdate(Update.prerestore, this.config);
			this.flow.dispatchUpdate(Update.restore);
		}
		
		
		
		update function tellGameWon(progress:GameConfig):void { this.flow.dispatchUpdate(Update.gameStopped); }
		update function tellRoundWon(progress:GameConfig):void { this.flow.dispatchUpdate(Update.gameStopped);	}
		update function tellRoundLost():void { this.flow.dispatchUpdate(Update.gameStopped); }
		
	}

}