package game.hud 
{
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	internal class EndGameView 
	{
		
		public function EndGameView(flow:IUpdateDispatcher) 
		{
			
			
			flow.workWithUpdateListener(this);
			flow.addUpdateListener(Update.gameFinished);
		}
		
		update function gameFinished(key:int):void
		{
			
		}
	}

}