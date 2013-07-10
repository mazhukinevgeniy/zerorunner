package chaotic.actors.manipulator.actions 
{
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.storage.ISearcher;
	import chaotic.metric.CellXY;
	
	public class Detonate
	{
		private const DAMAGE:int = 3;
		
		private var searcher:ISearcher;
		private var performer:IActionPerformer;
		
		public function Detonate(charFinder:ISearcher, newPerformer:IActionPerformer) 
		{
			this.searcher = charFinder;
			this.performer = newPerformer;
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
				this.performer.damageActor(targets[i], this.DAMAGE);
			}
		}
	}

}