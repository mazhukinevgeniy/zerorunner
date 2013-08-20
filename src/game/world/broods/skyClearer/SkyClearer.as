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
		private var world:ISearcher;
		
		private var points:IPointCollector;
		
		public function SkyClearer(foundations:GameFoundations, world:ISearcher, points:IPointCollector) 
		{
			this.foundations = foundations;
			this.world = world;
			
			this.points = points;
			
			super();
		}
		
		override protected function newActor():ItemLogicBase
		{
			var actor:ItemLogicBase = new SkyClearerLogic(this.foundations, this.world);
			
			this.points.addPointOfInterest(Game.TOWER, actor);
			
			return actor;
		}
		
		override protected function getActorsCap():int
		{
			return 30;
		}
		
		
	}

}