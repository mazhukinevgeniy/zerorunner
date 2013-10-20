package game.world.items.junk 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import utils.updates.update;
	
	public class Junk 
	{
		private var elements:GameElements;
		
		public function Junk(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			var i:int;
			
			for (i = 0; i < config.junks; i++)
				new JunkLogic(this.elements);
		}
	}

}