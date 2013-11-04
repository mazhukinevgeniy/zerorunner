package game.items.junk 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.items.MasterBase;
	import utils.updates.update;
	
	public class JunkMaster extends MasterBase 
	{
		private var elements:GameElements;
		
		public function JunkMaster(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			var i:int;
			
			for (i = 0; i < config.junks; i++)
				new Junk(this, this.elements);
		}
	}

}