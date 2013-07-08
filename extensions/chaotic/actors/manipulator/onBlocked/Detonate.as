package chaotic.actors.manipulator.onBlocked 
{
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.Puppet;
	import chaotic.actors.storage.ISearcher;
	import chaotic.metric.CellXY;
	
	public class Detonate extends AOEActionBase
	{
		private const DAMAGE:int = 3;
		
		public function Detonate(charFinder:ISearcher, newPerformer:IActionPerformer) 
		{
			this.searcher = charFinder;
			this.performer = newPerformer;
		}
		
		override public function actOn(item:Puppet):void
		{
			this.performer.detonateActor(item);
			
			var cell:CellXY = item.getCell();
			
			var targets:Vector.<Puppet> = this.getTargetsInSquare(cell.x - 1, cell.y - 1, 3);
			
			var length:int = targets.length;
			
			for (var i:int = 0; i < length; i++)
			{
				this.performer.damageActor(targets[i], this.DAMAGE);
			}
		}
		
		override public function prepareDataIn(item:Puppet):void
		{
			
		}
	}

}