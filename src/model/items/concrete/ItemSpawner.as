package model.items.concrete 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import controller.observers.IShardObserver;
	import model.items.ItemBase;
	import model.items.Items;
	import model.metric.CellXY;
	import model.projectiles.Projectile;
	import model.status.StatusReporter;
	
	public class ItemSpawner implements INewGameHandler, IShardObserver
	{
		private var binder:IBinder;
		private var items:Items;
		
		private var status:StatusReporter;
		
		private var tmpCell:CellXY;
		
		public function ItemSpawner(binder:IBinder, items:Items, status:StatusReporter) 
		{
			this.binder = binder;
			this.items = items;
			
			this.status = status;
			
			this.tmpCell = new CellXY(0, 0);
			
			binder.notifier.addObserver(this);
		}
		
		public function newGame():void
		{
			var map:XML = MapXML.getOne();
			
			var itemCodes:Array = new Array();
			
			for (var i:int = 0; i < map.tileset.length(); i++)
			{
				var name:String = map.tileset[i].@name;
				
				if (name == "hero")
					itemCodes[i + 1] = Game.ITEM_CHARACTER;
				else if (name == "goal")
					itemCodes[i + 1] = Game.ITEM_THE_GOAL;
				else if (name == "radar")
					itemCodes[i + 1] = Game.ITEM_BEACON;
				else if (name == "shard")
					itemCodes[i + 1] = Game.ITEM_SHARD;
			}
			
			var objects:XMLList = map.objectgroup[0].object;
			const LENGTH:int = objects.length();
			
			for (var j:int = 0; j < LENGTH; j++)
			{
				var type:int = itemCodes[objects[j].@gid];
				var x:int = int(objects[j].@x) / View.CELL_WIDTH;
				var y:int = int(objects[j].@y) / View.CELL_HEIGHT;
				
				if (type == Game.ITEM_CHARACTER)
					this.createCharacter(x, y);
				else if (type == Game.ITEM_THE_GOAL)
					this.createTheGoal(x, y);
				else if (type == Game.ITEM_SHARD)
					this.createShard(x, y);
				else if (type == Game.ITEM_BEACON)
					this.createBeacon(x, y);
			}
		}
		
		private function createBeacon(x:int, y:int):void 
		{
			this.tmpCell.setValue(x, y);
			
			new Beacon(this.items, this.binder, this.tmpCell);
		}
		
		private function createCharacter(x:int, y:int):void
		{
			this.tmpCell.setValue(x, y);
			var hero:ItemBase = new Character(this.items, this.binder, this.tmpCell);
			
			this.status.newHero(hero);
		}
		
		private function createShard(x:int, y:int):void
		{
			this.tmpCell.setValue(x, y);
			
			new Shard(this.items, this.binder, this.tmpCell);
		}
		
		private function createTheGoal(x:int, y:int):void
		{
			this.tmpCell.setValue(x, y);
			
			new TheGoal(this.items, this.binder, this.tmpCell);
		}
		//TODO: remove doublecode
		
		
		
		
		
		public function shardFellDown(shard:Projectile):void
		{
			this.createShard(shard.cell.x, shard.cell.y);
		}
	}

}