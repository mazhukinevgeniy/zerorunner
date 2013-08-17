package game.broods.checkpoint 
{
	import game.broods.BroodmotherBase;
	import game.broods.ItemLogicBase;
	
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