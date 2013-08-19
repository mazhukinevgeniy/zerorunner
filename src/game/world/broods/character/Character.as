package game.world.broods.character 
{
	import game.utils.GameFoundations;
	import game.utils.input.IKnowInput;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	import game.world.ISearcher;
	import utils.updates.IUpdateDispatcher;
	
	public class Character extends BroodmotherBase
	{
		private var foundations:GameFoundations;
		private var world:ISearcher;
		
		public function Character(foundations:GameFoundations, world:ISearcher) 
		{
			super(foundations);
			
			this.foundations = foundations;
			this.world = world;
		}
		
		override protected function getActorsCap():int { return 1; }
		
		override protected function newActor():ItemLogicBase
		{
			return new CharacterLogic(foundations, world);
		}
	}

}