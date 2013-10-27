package game.items 
{
	import data.viewers.GameConfig;
	import game.GameElements;
	import game.items.base.ItemBase;
	import game.items.beacon.Beacon;
	import game.items.character.Character;
	import game.items.junk.Junk;
	import game.items.technic.Technic;
	import game.items.utils.ItemUtils;
	import utils.updates.update;
	
	public class Items
	{
		private var items:Array;
		private var width:int;
		
		
		
		public function Items(elements:GameElements) 
		{
			new ItemUtils(this, elements.flow, elements.pointsOfInterest);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
			elements.flow.addUpdateListener(Update.quitGame);
			
			new Character(elements);
			new Beacon(elements);
			new Technic(elements);
			new Junk(elements);
		}
		
		
		update function prerestore(config:GameConfig):void
		{
			this.width = config.width + 2 * Game.BORDER_WIDTH;
			this.items = new Array();
		}
		
		update function quitGame():void
		{
			this.items = null;
		}
		
		
		
		items_internal function addItem(x:int, y:int, item:ItemBase):void
		{
			this.items[x + y * this.width] = item;
		}
		
		items_internal function removeItem(x:int, y:int):void
		{
			this.items[x + y * this.width] = null;
		}
		
		
		
		public function findObjectByCell(x:int, y:int):ItemBase
		{
			return this.items[x + y * this.width];
		}
	}

}