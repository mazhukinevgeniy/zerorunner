package game.world.items 
{
	import game.core.GameElements;
	import game.world.items.utils.IPointCollector;
	import game.world.items.utils.ISolderable;
	import game.world.items.utils.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	
	public class JunkLogic extends ItemLogicBase implements ISolderable
	{
		private var flow:IUpdateDispatcher;
		
		private var points:IPointCollector;
		
		public function JunkLogic(foundations:GameElements, points:IPointCollector) 
		{
			super(new JunkView(foundations), foundations);
			
			this.flow = foundations.flow;
			this.points = points;
		}
		
		public function applySoldering(value:int):void
		{
			this.applyDestruction();
			
			this.points.removePointOfInterest(Game.TOWER, this);
			
			this.flow.dispatchUpdate(Update.technicUnlocked, this);
		}
		
		public function get progress():Number
		{
			return 0;
		}
		
	}

}