package game.items 
{
	import data.viewers.GameConfig;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.beacon.BeaconMaster;
	import game.items.character.CharacterMaster;
	//import game.items.droid.DroidMaster;
	import game.items.junk.JunkMaster;
	import game.items.utils.ItemUtils;
	import game.points.IPointCollector;
	import utils.updates.update;
	
	
	public class Items
	{
		private var points:IPointCollector;
		
		private var items:Array;
		private var width:int;
		
		
		
		public function Items(elements:GameElements) 
		{
			new ItemUtils(this, elements.flow, elements.pointsOfInterest);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			new CharacterMaster(elements);
			new BeaconMaster(elements);
			//new DroidMaster(elements); //TODO: see DroidMaster.as
			new JunkMaster(elements);
		}
		
		
		update function prerestore(config:GameConfig):void
		{
			this.width = config.width + 2 * Game.BORDER_WIDTH;
			this.items = new Array();
		}
		
		update function numberedFrame(key:int):void
		{
			//TODO: check if can remove
		}
		
		update function quitGame():void
		{
			this.items = null;
		}
		
		
		
		internal function addItem(item:PuppetBase):void
		{
			if (this.items[item.x + item.y * this.width])
				throw new Error();
			this.items[item.x + item.y * this.width] = item;
		}
		
		internal function moveItemBy(item:PuppetBase, change:DCellXY):void
		{
			var blocker:PuppetBase = 
					this.findObjectByCell(item.x + change.x, item.y + change.y);
			
			if (!blocker)
			{
				//item.occupation.move
				//TODO: make something
				
				this.removeItem(item);
				
				item._x += change.x;
				item._y += change.y;
				
				this.addItem(item);
			}
			else
				throw new Error();
				//item.collider.collideWith(blocker);
				//TODO: handle such things inside of activities
		}
		
		internal function moveItemTo(item:PuppetBase, goal:ICoordinated):void
		{
			var blocker:PuppetBase = this.findObjectByCell(goal.x, goal.y);
			
			if (!blocker)
			{
				this.removeItem(item);
				
				item._x = goal.x;
				item._y = goal.y;
				
				this.addItem(item);
			}
			else
				throw new Error();
				//item.collider.collideWith(blocker);
				//TODO: handle such things inside of activities
		}
		
		internal function removeItem(item:PuppetBase):void
		{
			this.items[item.x + item.y * this.width] = null;
		}
		
		
		
		public function findObjectByCell(x:int, y:int):PuppetBase
		{
			return this.items[x + y * this.width];
		}
	}

}