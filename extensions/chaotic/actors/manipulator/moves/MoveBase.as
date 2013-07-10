package chaotic.actors.manipulator.moves 
{
	import chaotic.actors.manipulator.ActionBase;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.storage.ISearcher;
	import chaotic.errors.AbstractClassError;
	import chaotic.metric.DCellXY;
	
	internal class MoveBase extends ActionBase
	{
		protected var searcher:ISearcher;
		
		public function MoveBase() 
		{
			
		}
		
		final override public function actOn(item:Puppet, ... args):void
		{
			if (!(item.remainingDelay > 0))
				this.tryToMove(item);
		}
		
		protected function tryToMove(item:Puppet):void
		{
			throw new AbstractClassError();
		}
		
		final protected function callMove(item:Puppet, change:DCellXY):void
		{
			if (this.searcher.findObjectByCell(item.getCell().applyChanges(change)) == null)
			{
				this.onMoved(item, change);
			}
			else
				this.onBlocked(item, change);
		}
		
		protected function onMoved(item:Puppet, change:DCellXY):void
		{
			item.remainingDelay = item.speed;
			
			this.performer.movedActor(item, change);
		}
		
		protected function onBlocked(item:Puppet, change:DCellXY):void
		{
			
		}
	}

}