package game.items 
{
	import data.viewers.GameConfig;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.beacon.Beacon;
	import game.items.character.Character;
	import game.items.junk.Junk;
	import game.items.technic.Technic;
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
		
		update function numberedFrame(key:int):void
		{/*
			if (key == Game.UNUSED_FRAME_1) //right before you act
			{
				var pos:ICoordinated = this.character;
			
				for (var i:int = -5; i < 6; i++)
					for (var j:int = -5; j < 6; j++)
					{
						var item:ItemBase = this.items.findObjectByCell(pos.x + i, pos.y + j);
						
						if (item && item.contraption && !item.contraption.finished)
							this.points.addPointOfInterest(Game.TOWER, item.existence);
					}
			}*///TODO: realize where will it be in place
			//TODO: learn how to avoid the trouble when enlisted point dies
		}
		
		update function quitGame():void
		{
			this.items = null;
		}
		
		
		
		internal function addItem(item:ItemBase):void
		{
			this.items[item.x + item.y * this.width] = item;
		}
		
		internal function moveItemBy(item:ItemBase, change:DCellXY):void
		{
			var blocker:ItemBase = 
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
		
		internal function moveItemTo(item:ItemBase, goal:ICoordinated):void
		{
			var blocker:ItemBase = this.findObjectByCell(goal.x, goal.y);
			
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
		
		internal function removeItem(item:ItemBase):void
		{
			this.items[item.x + item.y * this.width] = null;
		}
		
		
		
		public function findObjectByCell(x:int, y:int):ItemBase
		{
			return this.items[x + y * this.width];
		}
	}

}