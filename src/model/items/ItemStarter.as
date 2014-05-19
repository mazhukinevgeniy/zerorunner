package model.items 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import model.items.beacon.BeaconMaster;
	import model.items.character.CharacterMaster;
	import model.items.shard.ShardMaster;
	import model.items.the_goal.TheGoalMaster;
	import model.status.StatusReporter;
	
	internal class ItemStarter implements INewGameHandler
	{
		
		private var masters:Vector.<MasterBase>;
		
		public function ItemStarter(binder:IBinder, items:Items, status:StatusReporter) 
		{
			this.masters = new Vector.<MasterBase>(Game.NUMBER_OF_ITEM_TYPES, true);
			
			this.masters[Game.ITEM_BEACON] = new BeaconMaster(binder, items);
			this.masters[Game.ITEM_CHARACTER] = new CharacterMaster(binder, items, status);
			this.masters[Game.ITEM_SHARD] = new ShardMaster(binder, items);
			this.masters[Game.ITEM_THE_GOAL] = new TheGoalMaster(binder, items);
			
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
				
				this.masters[type].spawnPuppet(x, y);
			}
		}
	}

}