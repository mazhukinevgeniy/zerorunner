package game.actors.types.character 
{
	import game.actors.types.BroodmotherBase;
	import game.input.IKnowInput;
	import utils.updates.IUpdateDispatcher;
	
	public class Character extends BroodmotherBase
	{
		
		public function Character(input:IKnowInput) 
		{
			super(CharacterLogic, input);
		}
		
		override protected function getActorsCap():int { return 1; }
	}

}