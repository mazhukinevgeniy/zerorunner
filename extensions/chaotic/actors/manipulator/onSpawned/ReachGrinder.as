package chaotic.actors.manipulator.onSpawned 
{
	import chaotic.actors.manipulator.ActionBase;
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.Puppet;
	import chaotic.grinder.IGrinder;
	import chaotic.metric.DCellXY;
	
	public class ReachGrinder extends ActionBase
	{
		private var grinders:IGrinder;
		
		public function ReachGrinder(performer:IActionPerformer, grinders:IGrinder) 
		{
			this.performer = performer;
			
			this.grinders = grinders;
		}
		
		
		override public function actOn(item:Puppet):void
		{
			var front:int = this.grinders.getFront(item.y);
			this.performer.replaceActor(item, new DCellXY(front - item.x, 0));
		}
		
		override public function prepareDataIn(item:Puppet):void
		{
			
		}
	}

}