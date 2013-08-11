package game.actors.types.character 
{
	import game.actors.types.ActorLogicBase;
	import game.actors.types.BroodmotherBase;
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
		
		override protected function newActor():ActorLogicBase
		{
			return new CharacterLogic(this.input);
		}
	}

}