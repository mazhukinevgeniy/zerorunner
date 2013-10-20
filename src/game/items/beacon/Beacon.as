package game.items.beacon 
{
	import data.viewers.GameConfig;
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
			new BeaconLogic(this.elements);
		}
		
	}

}