package game.broods.fog 
{
	import game.broods.BroodmotherBase;
	import game.broods.ItemLogicBase;
	
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
			return 200;
		}
		
		
		
		override public function actorOutOfCache(actor:ItemLogicBase):void
		{
			actor.applyDestruction();
		}
	}

}