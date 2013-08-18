package game.world.broods.checkpoint 
{
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	
	public class Checkpoint extends BroodmotherBase
	{
		public function Checkpoint() 
		{
			
		}
		
		override protected function getActorsCap():int
		{
			return 1;
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new CheckpointLogic();
		}
	}

}