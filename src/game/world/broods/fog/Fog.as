package game.world.broods.fog 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	import game.world.ISearcher;
	
	public class Fog extends BroodmotherBase
	{
		private var foundations:GameFoundations;
		private var world:ISearcher;
		
		public function Fog(foundations:GameFoundations, world:ISearcher) 
		{
			this.foundations = foundations;
			this.world = world;
			
			super();
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new FogLogic(this.foundations, this.world);
		}
		
		override protected function getActorsCap():int
		{
			return 200;
		}
		
	}

}