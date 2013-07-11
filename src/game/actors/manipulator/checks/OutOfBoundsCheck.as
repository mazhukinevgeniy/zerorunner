package game.actors.manipulator.checks 
{
	import game.actors.ActorsFeature;
	import game.actors.storage.Puppet;
	import game.metric.Metric;
	
	public class OutOfBoundsCheck extends CheckBase
	{
		private const MAXIMUM_DISTANCE:int = 40;
		
		public function OutOfBoundsCheck() 
		{
			
		}
		
		override public function actOn(item:Puppet, ... args):void
		{
			if (Metric.distance(item.getCell(), this.searcher.getCharacterCell()) > this.MAXIMUM_DISTANCE)
			{
				this.damageActor(item, ActorsFeature.MAXIMUM_DAMAGE);
			}
		}
	}

}