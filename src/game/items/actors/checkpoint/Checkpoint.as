package game.items.actors.checkpoint 
{
	import game.items.ActorLogicBase;
	import game.items.BroodmotherBase;
	
	public class Checkpoint extends BroodmotherBase
	{
		public function Checkpoint() 
		{
			
		}
		
		override protected function getActorsCap():int
		{
			return 1;
		}
		
		override protected function newActor():ActorLogicBase
		{
			return new CheckpointLogic();
		}
	}

}