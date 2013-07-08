package chaotic.actors.manipulator.checks 
{
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.storage.ISearcher;
	import chaotic.metric.Metric;
	
	public class OutOfBoundsCheck extends CheckBase
	{
		private var searcher:ISearcher;
		
		private const MAXIMUM_DISTANCE:int = 40;
		
		public function OutOfBoundsCheck(newPerformer:IActionPerformer, searcher:ISearcher) 
		{
			this.searcher = searcher;
			
			this.performer = newPerformer;
		}
		
		override public function actOn(item:Puppet, ... args):void
		{
			if (Metric.distance(item.getCell(), this.searcher.getCharacterCell()) > this.MAXIMUM_DISTANCE)
			{
				this.performer.destroyActor(item);
			}
		}
	}

}