package game.world.broods.fog 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	
	public class Fog extends BroodmotherBase
	{
		private var foundations:GameFoundations;
		
		public function Fog(foundations:GameFoundations) 
		{
			this.foundations = foundations;
			
			super();
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new FogLogic(this.foundations);
		}
		
		override protected function getActorsCap():int
		{
			return 200;
		}
		
	}

}