package game.items.skyClearer 
{
	import game.items.BroodmotherBase;
	import game.items.ItemLogicBase;
	
	public class SkyClearer extends BroodmotherBase implements IGiveTowers
	{
		
		public function SkyClearer() 
		{
			
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new SkyClearerLogic();
		}
		
		override protected function getActorsCap():int
		{
			return 20;
		}
		
		
		
		override public function actorOutOfCache(actor:ItemLogicBase):void
		{
			actor.applyDamage(6);
		}
		
		
		public function getRandomTower():ItemLogicBase
		{
			var actors:Vector.<ItemLogicBase> = this.getActors();
			
			return actors[int(Math.random() * actors.length)];
		}
	}

}