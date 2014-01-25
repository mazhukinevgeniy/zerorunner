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
			
			const NUMBER_OF_JUNKS:int = 4;
			
			for (i = 0; i < NUMBER_OF_JUNKS; i++)
				new Junk(this, this.elements);
		}
	}

}