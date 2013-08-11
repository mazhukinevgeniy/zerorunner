package game.actors.types.checkpoint 
{
	import game.actors.types.ActorLogicBase;
	import game.actors.types.BroodmotherBase;
	
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