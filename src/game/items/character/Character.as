package game.items.character 
{
	import game.items.BroodmotherBase;
	import game.items.ItemLogicBase;
	import game.ui.input.IKnowInput;
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