package game.items.technic 
{
	import game.items.BroodmotherBase;
	import game.items.ItemLogicBase;
	import game.items.skyClearer.IGiveTowers;
	
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