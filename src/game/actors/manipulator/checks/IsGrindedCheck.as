package game.actors.manipulator.checks 
{
	import game.actors.manipulator.IActionPerformer;
	import game.actors.storage.Puppet;
	import game.grinder.IGrinder;
	
	public class IsGrindedCheck extends CheckBase
	{
		private var grinder:IGrinder;
		
		
		public function IsGrindedCheck(newGrinder:IGrinder, newPerformer:IActionPerformer) 
		{
			this.grinder = newGrinder;
			this.performer = newPerformer;
		}
		
		
		override public function actOn(item:Puppet, ... args):void
		{
			if (this.grinder.isGrinded(item.getCell()))
			{
				this.performer.destroyActor(item);
			}
			
		}
	}

}