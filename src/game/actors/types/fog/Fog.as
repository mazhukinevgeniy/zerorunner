package game.actors.types.fog 
{
	import game.actors.types.ActorLogicBase;
	import game.actors.types.BroodmotherBase;
	
	public class Fog extends BroodmotherBase
	{
		
		public function Fog() 
		{
			
		}
		
		override protected function newActor():ActorLogicBase
		{
			return new FogLogic();
		}
		
		override protected function getActorsCap():int
		{
			return 50;
		}
		
		
		
		override public function actorOutOfCache(actor:ActorLogicBase):void
		{
			actor.applyDestruction();
		}
	}

}