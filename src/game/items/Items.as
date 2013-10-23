package game.items 
{
	import data.viewers.GameConfig;
	import game.core.metric.DCellXY;
	import game.GameElements;
	import game.items.base.cores.ExistenceCore;
	import game.items.base.ItemBase;
	import game.items.beacon.Beacon;
	import game.items.character.Character;
	import game.items.junk.Junk;
	import game.items.technic.Technic;
	import utils.updates.update;
	
	public class Items implements IActors, IActorTracker
	{
		private var items:Array;
		private var width:int;
		
		
		
		public function Items(foundations:GameElements) 
		{
			new ItemUtils(this, foundations.flow, foundations.pointsOfInterest);
			
			foundations.flow.workWithUpdateListener(this);
			foundations.flow.addUpdateListener(Update.prerestore);
			foundations.flow.addUpdateListener(Update.quitGame);
			
			new Character(foundations);
			new Beacon(foundations);
			new Technic(foundations);
			new Junk(foundations);
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
		
		
		
		items_internal function addItem(item:ExistenceCore):void
		{
			this.items[item.x + item.y * this.width] = item;
		}
		
		items_internal function moveItem(item:ExistenceCore, change:DCellXY):void
		{
			this.items[item.x - change.x + (item.y - change.y) * this.width] = null;
			this.items[item.x + item.y * this.width] = item;
		}
		
		items_internal function removeItem(item:ExistenceCore):void
		{
			this.items[item.x + item.y * this.width] = null;
		}
		
		
		
		public function findObjectByCell(x:int, y:int):ItemBase
		{
			return this.items[x + y * this.width];
		}
	}

}