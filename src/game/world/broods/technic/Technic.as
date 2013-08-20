package game.world.broods.technic 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.IPointCollector;
	import game.world.ISearcher;
	
	public class Technic extends BroodmotherBase
	{
		private var towers:IPointCollector;
		
		
		private var foundations:GameFoundations;
		private var world:ISearcher;
		
		public function Technic(foundations:GameFoundations, world:ISearcher, towers:IPointCollector) 
		{
			this.foundations = foundations;
			this.world = world;
			this.towers = towers;
			
			super();
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new TechnicLogic(this.foundations, this.world, this.towers);
		}
		
		override protected function getActorsCap():int
		{
			return 1;
		}
		
		
	}

}