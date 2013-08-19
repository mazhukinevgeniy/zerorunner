package game.world.broods.technic 
{
	import game.utils.GameFoundations;
	import game.world.broods.BroodmotherBase;
	import game.world.broods.ItemLogicBase;
	import game.world.broods.utils.IPointCollector;
	
	public class Technic extends BroodmotherBase
	{
		private var towers:IPointCollector;
		
		public function Technic(foundations:GameFoundations, towers:IPointCollector) 
		{
			super(foundations);
			
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
		
		
	}

}