package game.actors.manipulator.actions 
{
	import chaotic.core.IUpdateDispatcher;
	import game.actors.ActorsFeature;
	import game.actors.manipulator.IActionPerformer;
	import game.actors.storage.Puppet;
	import game.actors.storage.ISearcher;
	import game.metric.CellXY;
	
	public class Detonate
	{
		private const DAMAGE:int = 3;
		
		private var searcher:ISearcher;
		private var performer:IActionPerformer;
		private var flow:IUpdateDispatcher;
		
		public function Detonate(charFinder:ISearcher, newPerformer:IActionPerformer, flow:IUpdateDispatcher) 
		{
			this.searcher = charFinder;
			this.performer = newPerformer;
			this.flow = flow;
		}
		
		public function act(item:Puppet):void
		{
			this.performer.detonateActor(item);
			
			var cell:CellXY = item.getCell();
			
			var targets:Vector.<Puppet> = this.searcher.findObjectsInSquare(cell.x - 1, cell.y - 1, 3);
			targets.splice(targets.indexOf(item), 1);
			
			var length:int = targets.length;
			
			for (var i:int = 0; i < length; i++)
			{
				this.flow.dispatchUpdate(ActorsFeature.damageActor, targets[i], this.DAMAGE);
			}
		}
	}

}