package game.items.technic 
{
	import data.viewers.GameConfig;
	import game.core.metric.CellXY;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import utils.updates.update;
	
	public class Technic
	{
		private var elements:GameElements;
		
		public function Technic(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
			elements.flow.addUpdateListener(Update.technicUnlocked);
		}
		
		update function prerestore(config:GameConfig):void
		{
			var i:int;
			
			for (i = 0; i < config.numberOfDroids; i++)
			{
				var center:ICoordinated = this.elements.pointsOfInterest.findPointOfInterest(Game.CHARACTER);
				
				var tmpCell:CellXY = Metric.getTmpCell(center.x - 4, center.y + 4);
				
				while (this.elements.items.findObjectByCell(tmpCell.x, tmpCell.y))
					tmpCell.setValue(tmpCell.x, tmpCell.y - 1);
				
				new TechnicLogic(tmpCell, this.elements);
			}
		}
		
		update function technicUnlocked(place:ICoordinated):void
		{
			var technic:TechnicLogic = new TechnicLogic(place, this.elements);
		}
	}

}