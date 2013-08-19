package game.world.broods.checkpoint 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	
	public class Checkpoint extends BroodmotherBase
	{
		public function Checkpoint(foundations:GameFoundations) 
		{
			super(foundations);
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