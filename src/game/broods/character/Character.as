package game.broods.character 
{
	import game.broods.BroodmotherBase;
	import game.broods.ItemLogicBase;
	import game.input.IKnowInput;
	import utils.updates.IUpdateDispatcher;
	
	public class Character extends BroodmotherBase
	{
		private var input:IKnowInput;
		
		public function Character(input:IKnowInput) 
		{
			this.input = input;
		}
		
		override protected function getActorsCap():int { return 1; }
		
		override protected function newActor():ItemLogicBase
		{
			return new CharacterLogic(this.input);
		}
	}

}