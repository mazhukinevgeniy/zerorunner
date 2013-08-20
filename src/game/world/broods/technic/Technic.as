package game.world.broods.technic 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.IPointCollector;
	
	public class Technic extends BroodmotherBase
	{
		private var towers:IPointCollector;
		
		
		private var foundations:GameFoundations;
		
		public function Technic(foundations:GameFoundations, towers:IPointCollector) 
		{
			this.foundations = foundations;
			this.towers = towers;
			
			super();
		}
		
		override protected function newActor():ItemLogicBase
		{
			return new TechnicLogic(this.foundations, this.towers);
		}
		
		override protected function getActorsCap():int
		{
			return 1;
		}
		
		
	}

}