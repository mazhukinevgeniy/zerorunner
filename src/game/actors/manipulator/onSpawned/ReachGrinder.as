package game.actors.manipulator.onSpawned 
{
	import game.actors.manipulator.ActionBase;
	import game.actors.manipulator.IActionPerformer;
	import game.actors.storage.ISearcher;
	import game.actors.storage.Puppet;
	import game.grinder.IGrinder;
	import game.metric.CellXY;
	import game.metric.DCellXY;
	
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