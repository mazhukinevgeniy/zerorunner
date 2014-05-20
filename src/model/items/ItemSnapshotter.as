package model.items 
{
	import binding.IBinder;
	import model.interfaces.IItemSnapshotter;
	
	internal class ItemSnapshotter implements IItemSnapshotter
	{
		private var items:Items;
		private var pool:ItemSnapshotPool;
		
		public function ItemSnapshotter(items:Items, binder:IBinder) 
		{
			binder.addBindable(this, IItemSnapshotter);
			
			this.items = items;
			this.pool = new ItemSnapshotPool(binder);
		}
		
		public function getItemSnapshot(cellId:int):ItemSnapshot
		{
			var item:ItemBase = this.items.getItem(cellId);
			var shot:ItemSnapshot;
			
			if (item)
			{
				shot = this.pool.getSnapshot();
				
				shot._type = item.type;
				
				shot._direction = item.direction;
				shot._occ = item.occupation;
				
				shot._width = item.width;
				shot._height = item.height;
				
				shot._prog = Number(item.framesOccupated) / item.framesUntilOccupationEnds;
				
				shot._x = Number(item.x);
				shot._y = Number(item.y);
				
				if (item.occupation == Game.OCCUPATION_MOVING)
				{
					var dir:int = item.direction;
					
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
			
			return shot;
		}
	}

}