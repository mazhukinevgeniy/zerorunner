package game.state 
{
	import game.actors.ActorsFeature;
	import game.ZeroRunner;
	import utils.informers.IStoreInformers;
	import utils.updates.IUpdateDispatcher;
	import utils.updates.update;
	
	public class GameState implements IGameState
	{
		private var ticks:uint;
		
		public function GameState(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.prerestore);
			flow.addUpdateListener(ZeroRunner.aftertick);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
		}
		
		update function prerestore():void
		{
			this.ticks = 0;
		}
		
		update function aftertick():void
		{
			this.ticks++;
		}
		
		update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IGameState, this);
		}
		
		//public function get ticksPassed():uint
		//{
		//	return this.ticks;
		//}
		//TODO: remove if never required
		
	}

}