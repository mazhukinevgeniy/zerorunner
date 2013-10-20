package game.world.items.technic 
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
				new TechnicLogic(this.elements);
		}
		
		update function technicUnlocked(place:ICoordinated):void
		{
			var technic:TechnicLogic = new TechnicLogic(this.elements);
			technic.moveTo(place);
		}
	}

}