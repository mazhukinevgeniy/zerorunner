package game.world.broods.skyClearer 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.IPointCollector;
	import game.world.ISearcher;
	
	public class SkyClearer extends BroodmotherBase
	{
		private var foundations:GameFoundations;
		
		public function SkyClearer(foundations:GameFoundations) 
		{
			this.foundations = foundations;
			
			super();
		}
		
		override protected function newActor():ItemLogicBase
		{
			var actor:ItemLogicBase = new SkyClearerLogic(this.foundations);
			
			return actor;
		}
		
		override protected function getActorsCap():int
		{
			return 3000;
		}
		
		
	}

}