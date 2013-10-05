package game.world.items.junk 
{
	import game.core.GameFoundations;
	import game.core.metric.Metric;
	import game.world.items.ISolderable;
	import game.world.items.ItemLogicBase;
	import game.world.items.technic.TechnicLogic;
	import game.world.items.utils.IPointCollector;
	
	public class JunkLogic extends ItemLogicBase implements ISolderable
	{
		private var technic:TechnicLogic;
		
		public function JunkLogic(foundations:GameFoundations, points:IPointCollector) 
		{
			this.technic = new TechnicLogic(foundations, points);
			this.technic.applyDestruction();
			
			super(new JunkView(foundations), foundations);
		}
		
		public function applySoldering(value:int):void
		{
			this.technic.reset();
			
			this.applyDestruction();
			
			this.technic.move(Metric.getTmpDCell(this.x - this.technic.x, this.y - this.technic.y), -1);
		}
		
		public function get progress():Number
		{
			return 0;
		}
		
	}

}