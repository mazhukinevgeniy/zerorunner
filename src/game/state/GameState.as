package game.state 
{
	import chaotic.core.IUpdateDispatcher;
	import chaotic.core.update;
	import chaotic.informers.IStoreInformers;
	import game.actors.ActorsFeature;
	import game.ZeroRunner;
	
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
		
		public function get actualActorsCap():uint
		{
			const INF:int = 50;
			const TICK_STEP:int = 300;
			const ACTOR_STEP:int = 25;
			
			return Math.min(INF + (this.ticks / TICK_STEP) * ACTOR_STEP, ActorsFeature.CAP);
		}
		
	}

}