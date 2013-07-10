package game.actors.manipulator.moves 
{
	import game.actors.manipulator.IActionPerformer;
	import game.actors.storage.Puppet;
	import game.actors.storage.ISearcher;
	import game.metric.DCellXY;
	import game.metric.Metric;
	
	public class InertialRandom extends MoveBase
	{
		
		public function InertialRandom(newPerformer:IActionPerformer, newSearcher:ISearcher) 
		{
			this.searcher = newSearcher;
			
			this.performer = newPerformer;
		}
		
		override public function prepareDataIn(item:Puppet):void
		{
			var data:Object = (item.data.inertialRandom = new Object());
			
			data.stepsToDo = new int(0);
			data.change = new DCellXY(0, 0);
		}
		
		override protected function tryToMove(item:Puppet):void
		{
			var data:Object = item.data.inertialRandom;
			
			if (!(data.stepsToDo > 0))
			{
				data.change = Metric.getRandomDCell();
				
				data.stepsToDo = int(Math.random() * 7);
			}
			
			this.callMove(item, data.change);
			
			data.stepsToDo--;
		}
		
	}

}