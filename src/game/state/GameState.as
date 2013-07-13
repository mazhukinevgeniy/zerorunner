package game.state 
{
	import chaotic.core.IUpdateDispatcher;
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
		
		public function restore():void
		{
			this.ticks = 0;
		}
		
		public function tick():void
		{
			this.ticks++;
		}
		
		public function addInformerTo(table:IStoreInformers):void
		{
			table.addInformer(IGameState, this);
		}
		
		public function get ticksPassed():uint
		{
			return this.ticks;
		}
	}

}