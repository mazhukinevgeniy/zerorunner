package game.items.junk 
{
	import game.GameElements;
	import game.items.base.ISolderable;
	import game.items.base.ItemBase;
	import game.points.IPointCollector;
	import utils.updates.IUpdateDispatcher;
	
	internal class JunkLogic extends ItemBase
	{
		private var flow:IUpdateDispatcher;
		
		private var points:IPointCollector;
		
		public function JunkLogic(foundations:GameElements) 
		{
			super(new JunkView(foundations), foundations);
			
			this.flow = foundations.flow;
			this.points = foundations.pointsOfInterest;
		}
		
	}

}