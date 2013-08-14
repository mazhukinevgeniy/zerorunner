package game.items.checkpoint 
{
	import game.items.BroodmotherBase;
	import game.items.ItemLogicBase;
	
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