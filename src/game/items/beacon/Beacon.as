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
			var cell:CellXY = new CellXY(Game.BORDER_WIDTH + config.width - 1, 
										 Game.BORDER_WIDTH);
			
			new BeaconLogic(cell, this.elements);
		}
	}

}