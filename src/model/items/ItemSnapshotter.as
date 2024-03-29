package model.items 
{
	import binding.IBinder;
	import events.GlobalEvent;
	import model.interfaces.IItemSnapshotter;
	import utils.StructPool;
	
	internal class ItemSnapshotter implements IItemSnapshotter
	{
		private var storage:ItemStorage;
		private var pool:StructPool;
		
		public function ItemSnapshotter(storage:ItemStorage, binder:IBinder) 
		{
			this.storage = storage;
			this.pool = new StructPool(ItemSnapshot);
			
			binder.eventDispatcher.addEventListener(GlobalEvent.GAME_FRAME, 
			                                        this.pool.freeEverythingUsed);
			//TODO: check if we really need that
		}
		
		public function getItemSnapshot(cellId:int):ItemSnapshot
		{
			var item:ItemBase = this.storage.getItem(cellId);
			var shot:ItemSnapshot;
			
			if (item)
			{
				shot = this.pool.getStruct();
				
				shot._type = item.type;
				
				shot._direction = item.direction;
				shot._occ = item.occupation;
				
				shot._width = item.width;
				shot._height = item.height;
				
				shot._prog = Number(item.framesOccupated) / 
							        item.framesUntilOccupationEnds;
				
				shot._x = Number(item.x);
				shot._y = Number(item.y);
				
				this.setExactCoordinatesFor(shot);
			}
			
			return shot;
		}
		
		private function setExactCoordinatesFor(shot:ItemSnapshot):void
		{
			var dir:int = shot._direction;
			
			if (dir == Game.DIRECTION_RIGHT)
				shot._x -= 1 - shot._prog;
			else if (dir == Game.DIRECTION_TOP)
				shot._y += 1 - shot._prog;
			else if (dir == Game.DIRECTION_LEFT)
				shot._x += 1 - shot._prog;
			else if (dir == Game.DIRECTION_DOWN)
				shot._y -= 1 - shot._prog;
		}
	}

}