package game.world.broods.character 
{
	import game.utils.GameFoundations;
	import game.utils.input.IKnowInput;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	
	public class Character extends BroodmotherBase
	{
		private var input:IKnowInput;
		
		public function Character(foundations:GameFoundations) 
		{
			super(foundations);
			
			this.input = foundations.input;
		}
		
		override protected function getActorsCap():int { return 1; }
		
		override protected function newActor():ItemLogicBase
		{
			return new CharacterLogic(this.input);
		}
	}

}