package game.world.broods.skyClearer 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	
	public class SkyClearer extends BroodmotherBase
	{
		
		public function SkyClearer(foundations:GameFoundations) 
		{
			super(foundations);
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