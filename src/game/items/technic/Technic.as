package game.items.technic 
{
	import game.items.BroodmotherBase;
	import game.items.ItemLogicBase;
	
	public class Technic extends BroodmotherBase
	{
		
		public function Technic() 
		{
			
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new TechnicLogic();
		}
		
		override protected function getActorsCap():int
		{
			return 3;
		}
		
		
		
		override public function actorOutOfCache(actor:ItemLogicBase):void
		{
			actor.applyDestruction();
		}
		
	}

}