package game.actors.manipulator.checks 
{
	import game.actors.ActorsFeature;
	import game.actors.storage.Puppet;
	import game.grinder.IGrinder;
	
	public class IsGrindedCheck extends CheckBase
	{
		private var grinder:IGrinder;
		
		
		public function IsGrindedCheck(newGrinder:IGrinder) 
		{
			this.grinder = newGrinder;
		}
		
		
		override public function actOn(item:Puppet, ... args):void
		{
			if (this.grinder.isGrinded(item.getCell()))
			{
				this.damageActor(item, ActorsFeature.MAXIMUM_DAMAGE);
			}
			
		}
	}

}