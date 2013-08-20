package game.world.broods.checkpoint 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	
	public class Checkpoint extends BroodmotherBase
	{
		private var foundations:GameFoundations;
		
		public function Checkpoint(foundations:GameFoundations) 
		{
			this.foundations = foundations;
			
			super();
		}
		
		override protected function getActorsCap():int
		{
			return 1;
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new CheckpointLogic(this.foundations);
		}
	}

}