package game.world.broods.checkpoint 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	import game.world.ISearcher;
	
	public class Checkpoint extends BroodmotherBase
	{
		private var foundations:GameFoundations;
		private var world:ISearcher;
		
		public function Checkpoint(foundations:GameFoundations, world:ISearcher) 
		{
			super(foundations);
			
			this.foundations = foundations;
			this.world = world;
		}
		
		override protected function getActorsCap():int
		{
			return 1;
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new CheckpointLogic(foundations, world);
		}
	}

}