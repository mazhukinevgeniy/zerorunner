package game.items.technic 
{
	import data.viewers.GameConfig;
	import game.core.metric.ICoordinated;
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
			{/*
				this.center = this.points.findPointOfInterest(Game.CHARACTER);
				
				var tmpCell:CellXY = Metric.getTmpCell(this.center.x - 4, this.center.y + 4);
				
				while (this.actors.findObjectByCell(tmpCell.x, tmpCell.y))
					tmpCell.setValue(tmpCell.x, tmpCell.y - 1);
				
				return tmpCell;*/
				new TechnicLogic(this.elements);
			}
		}
		
		update function technicUnlocked(place:ICoordinated):void
		{
			var technic:TechnicLogic = new TechnicLogic(place, this.elements);
		}
	}

}