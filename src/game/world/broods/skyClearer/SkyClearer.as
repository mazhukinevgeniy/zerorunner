package game.world.broods.skyClearer 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	import game.world.ISearcher;
	
	public class SkyClearer extends BroodmotherBase
	{
		private var foundations:GameFoundations;
		private var world:ISearcher;
		
		public function SkyClearer(foundations:GameFoundations, world:ISearcher) 
		{
			super(foundations);
			
			this.foundations = foundations;
			this.world = world;
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new SkyClearerLogic(this.foundations, this.world);
		}
		
		override protected function getActorsCap():int
		{
			return 30;
		}
		
		
	}

}