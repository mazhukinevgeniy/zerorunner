package chaotic.actors.manipulator.onBlocked 
{
	import chaotic.actors.manipulator.ActionBase;
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.storage.ISearcher;
	
	public class Bite extends ActionBase
	{
		private var actors:ISearcher;
		
		private const DAMAGE:int = 5;
		
		public function Bite(performer:IActionPerformer, actors:ISearcher) 
		{
			this.performer = performer;
			this.actors = actors;
		}
		
		
		override public function actOn(item:Puppet, ... args):void
		{
			var target:Puppet = this.actors.findObjectByCell((item.getCell()).applyChanges(item.attemptedMove));
			
			this.performer.damageActor(target, this.DAMAGE);
		}
		
		override public function prepareDataIn(item:Puppet):void
		{
			
		}
	}

}