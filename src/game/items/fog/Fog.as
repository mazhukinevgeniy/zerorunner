package game.items.fog 
{
	import game.items.BroodmotherBase;
	import game.items.ItemLogicBase;
	
	public class Fog extends BroodmotherBase
	{
		
		public function Fog() 
		{
			
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new FogLogic();
		}
		
		override protected function getActorsCap():int
		{
			return 50;
		}
		
		
		
		override public function actorOutOfCache(actor:ItemLogicBase):void
		{
			actor.applyDestruction();
		}
	}

}