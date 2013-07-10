package game.actors.manipulator.actions 
{
	import game.actors.manipulator.IActionPerformer;
	import game.actors.storage.Puppet;
	import game.actors.storage.ISearcher;
	import game.metric.DCellXY;
	
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