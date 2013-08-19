package game.world.broods.skyClearer 
{
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	
	public class SkyClearer extends BroodmotherBase
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
			return 30;
		}
		
		
	}

}