package game.items.beacon 
{
	import data.viewers.GameConfig;
	import game.core.metric.CellXY;
	import game.GameElements;
	import game.items.MasterBase;
	import utils.updates.update;
	
	public class BeaconMaster extends MasterBase
	{
		private var elements:GameElements;
		
		public function BeaconMaster(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			var cell:CellXY = new CellXY(Game.MAP_WIDTH - 11, 
										 10);//TODO: get rid of this dirty hardcode
			
			new Beacon(this, this.elements, cell);
		}
	}

}