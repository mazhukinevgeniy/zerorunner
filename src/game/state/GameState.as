package game.state 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.informers.IStoreInformers;
	import game.ZeroRunner;
	
	public class GameState implements IGameState
	{
		private var ticks:uint;
		
		public function GameState(flow:IUpdateDispatcher) 
		{
			flow.workWithUpdateListener(this);
			
			flow.addUpdateListener(ZeroRunner.restore);
			flow.addUpdateListener(ZeroRunner.tick);
			flow.addUpdateListener(ZeroRunner.addInformerTo);
		}
		
		update function restore():void
		{
			this.ticks = 0;
		}
		
		update function tick():void
		{
			this.ticks++;
		}
		
		update function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IGameState, this);
		}
		
		public function get ticksPassed():uint
		{
			return this.ticks;
		}
		
		
	}

}