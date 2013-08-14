package game.items.actors.character 
{
	import game.input.IKnowInput;
	import game.items.ActorLogicBase;
	import game.items.BroodmotherBase;
	import utils.updates.IUpdateDispatcher;
	
	public class Character extends BroodmotherBase
	{
		private var input:IKnowInput;
		
		public function Character(input:IKnowInput) 
		{
			this.input = input;
		}
		
		override protected function getActorsCap():int { return 1; }
		
		override protected function newActor():ActorLogicBase
		{
			return new CharacterLogic(this.input);
		}
	}

}