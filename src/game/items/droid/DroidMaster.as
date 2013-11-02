package game.items.droid 
{
	import data.viewers.GameConfig;
	import game.core.metric.CellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import game.items.MasterBase;
	import utils.updates.update;
	
	public class DroidMaster extends MasterBase
	{
		private var elements:GameElements;
		
		public function DroidMaster(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
			elements.flow.addUpdateListener(Update.droidUnlocked);
		}
		
		update function prerestore(config:GameConfig):void
		{
			var i:int;
			
			for (i = 0; i < config.numberOfDroids; i++)
			{
				var center:ICoordinated = this.elements.pointsOfInterest.getCharacter();
				
				var tmpCell:CellXY = new CellXY(center.x - 4, center.y + 4);
				
				while (this.elements.items.findObjectByCell(tmpCell.x, tmpCell.y))
					tmpCell.setValue(tmpCell.x, tmpCell.y - 1);
				
				new Droid(tmpCell, this.elements);
			}
		}
		
		update function droidUnlocked(place:CellXY):void
		{
			new Droid(place, this.elements);
		}
	}

}