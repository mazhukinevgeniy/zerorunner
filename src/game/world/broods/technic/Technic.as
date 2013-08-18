package game.world.broods.technic 
{
	import game.world.broods.BroodmotherBase;
	import game.world.broods.IGiveTowers;
	import game.world.broods.ItemLogicBase;
	
	public class Technic extends BroodmotherBase
	{
		private var towers:IGiveTowers;
		
		public function Technic(towers:IGiveTowers) 
		{
			this.towers = towers;
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new TechnicLogic(this.towers);
		}
		
		override protected function getActorsCap():int
		{
			return 1;
		}
		
		
		override public function actorOutOfCache(actor:ItemLogicBase):void
		{
			actor.applyDamage(2);
		}
	}

}