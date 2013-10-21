package game.items.beacon 
{
	import data.viewers.GameConfig;
	import game.core.metric.CellXY;
	import game.core.metric.Metric;
	import game.GameElements;
	import utils.updates.update;
	
	public class Beacon
	{
		private var elements:GameElements;
		
		public function Beacon(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			do
				var cell:CellXY = this.getCell();
			while (this.elements.actors.findObjectByCell(cell.x, cell.y));
			
			new BeaconLogic(cell, this.elements);
		}
		
		private function getCell():CellXY
		{
			return Metric.getTmpCell(Game.BORDER_WIDTH + this.config.width - 1, 
									 Game.BORDER_WIDTH);
		}
	}

}