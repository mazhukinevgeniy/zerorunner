package chaotic.actors.manipulator.actions 
{
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.storage.ISearcher;
	import chaotic.metric.DCellXY;
	
	public class Bite
	{
		private var actors:ISearcher;
		private var performer:IActionPerformer;
		
		private const DAMAGE:int = 5;
		
		public function Bite(performer:IActionPerformer, actors:ISearcher) 
		{
			this.performer = performer;
			this.actors = actors;
		}
		
		
		public function act(item:Puppet, change:DCellXY):void
		{
			var target:Puppet = this.actors.findObjectByCell((item.getCell()).applyChanges(change));
			
			this.performer.damageActor(target, this.DAMAGE);
		}
	}

}