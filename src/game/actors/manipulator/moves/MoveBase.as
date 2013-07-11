package game.actors.manipulator.moves 
{
	import game.actors.manipulator.ActionBase;
	import game.actors.storage.Puppet;
	import game.actors.storage.ISearcher;
	import chaotic.errors.AbstractClassError;
	import game.metric.DCellXY;
	
	internal class MoveBase extends ActionBase
	{
		
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
		
		
		
		
	}

}