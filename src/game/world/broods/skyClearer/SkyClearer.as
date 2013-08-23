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
		
		private var points:IPointCollector;
		
		public function SkyClearer(foundations:GameFoundations, points:IPointCollector) 
		{
			this.foundations = foundations;
			
			this.points = points;
			
			super();
		}
		
		override protected function newActor():ItemLogicBase
		{
			var actor:ItemLogicBase = new SkyClearerLogic(this.foundations);
			
			this.points.addPointOfInterest(Game.TOWER, actor);
			
			return actor;
		}
		
		override protected function getActorsCap():int
		{
			return 3000;
		}
		
		
	}

}