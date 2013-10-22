package game.items.character 
{
	import data.viewers.GameConfig;
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
			new CharacterLogic(this.elements);
		}
	}

}