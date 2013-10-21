package game.items.character 
{
	import data.viewers.GameConfig;
	import game.core.metric.ICoordinated;
	import game.core.metric.Metric;
	import game.GameElements;
	import utils.updates.update;
	
	public class Character 
	{
		private var elements:GameElements;
		
		public function Character(elements:GameElements) 
		{
			this.elements = elements;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
		}
		
		update function prerestore(config:GameConfig):void
		{
			var cell:ICoordinated = 
				Metric.getTmpCell(Game.BORDER_WIDTH, 
								  Game.BORDER_WIDTH + config.width - 1);
			
			new CharacterLogic(cell, this.elements);
		}
	}

}