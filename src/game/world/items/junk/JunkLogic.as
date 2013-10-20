package game.world.items.junk 
{
	import game.GameElements;
	import game.world.items.IPointCollector;
	import game.world.items.ISolderable;
	import game.world.items.ItemLogicBase;
	import utils.updates.IUpdateDispatcher;
	
	internal class JunkLogic extends ItemLogicBase implements ISolderable
	{
		private var flow:IUpdateDispatcher;
		
		private var points:IPointCollector;
		
		public function JunkLogic(foundations:GameElements) 
		{
			super(new JunkView(foundations), foundations);
			
			this.flow = foundations.flow;
			this.points = foundations.pointsOfInterest;
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