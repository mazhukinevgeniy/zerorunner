package game.world.broods.fog 
{
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	
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
		
	}

}