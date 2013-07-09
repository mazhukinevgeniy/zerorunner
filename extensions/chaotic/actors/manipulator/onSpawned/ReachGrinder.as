package chaotic.actors.manipulator.onSpawned 
{
	import chaotic.actors.manipulator.ActionBase;
	import chaotic.actors.manipulator.IActionPerformer;
	import chaotic.actors.storage.ISearcher;
	import chaotic.actors.storage.Puppet;
	import chaotic.grinder.IGrinder;
	import chaotic.metric.CellXY;
	import chaotic.metric.DCellXY;
	
	public class ReachGrinder extends ActionBase
	{
		private var grinders:IGrinder;
		private var actors:ISearcher;
		
		private var up:DCellXY = new DCellXY(0, -1);
		
		public function ReachGrinder(performer:IActionPerformer, grinders:IGrinder, actors:ISearcher) 
		{
			this.performer = performer;
			
			this.grinders = grinders;
			this.actors = actors;
		}
		
		
		override public function actOn(item:Puppet, ... args):void
		{
			var front:int = this.grinders.getFront(item.y);
			
			var dY:int = 0;
			
			var tmpCell:CellXY = new CellXY(front, item.y);
			
			while (this.actors.findObjectByCell(tmpCell))
			{
				tmpCell.applyChanges(this.up);
				dY--;
			}
			
			this.performer.replaceActor(item, new DCellXY(front - item.x, dY));
		}
		
		override public function prepareDataIn(item:Puppet):void
		{
			
		}
	}

}