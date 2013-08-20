package game.world.broods.character 
{
	import game.utils.GameFoundations;
	import game.utils.input.IKnowInput;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.IPointCollector;
	import game.world.ISearcher;
	import utils.updates.IUpdateDispatcher;
	
	public class Character extends BroodmotherBase
	{
		private var foundations:GameFoundations;
		private var world:ISearcher;
		
		private var points:IPointCollector;
		
		public function Character(foundations:GameFoundations, world:ISearcher, points:IPointCollector) 
		{
			this.foundations = foundations;
			this.world = world;
			
			this.points = points;
			
			super();
		}
		
		override protected function getActorsCap():int { return 1; }
		
		override protected function newActor():ItemLogicBase
		{
			var actor:ItemLogicBase = new CharacterLogic(this.foundations, this.world);
			
			this.points.addPointOfInterest(Game.CHARACTER, actor);
			return actor;
		}
	}

}