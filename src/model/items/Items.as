package model.items 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import controller.observers.IQuitGameHandler;
	import model.interfaces.IPuppets;
	import model.interfaces.IStatus;
	import model.items.beacon.BeaconMaster;
	import model.items.character.CharacterMaster;
	import model.items.shard.ShardMaster;
	import model.items.the_goal.TheGoalMaster;
	import model.metric.ICoordinated;
	import model.status.StatusReporter;
	import model.utils.normalize;
	
	public class Items implements IPuppets,
	                              INewGameHandler, 
	                              IGameFrameHandler, 
								  IQuitGameHandler
	{
		private var items:Array;
		
		private var masters:Vector.<MasterBase>;
		
		
		private var status:IStatus;
		
		public function Items(binder:IBinder, status:StatusReporter) 
		{
			this.status = status;
			
			binder.notifier.addObserver(this);
			
			this.masters = new Vector.<MasterBase>(Game.NUMBER_OF_ITEM_TYPES, true);
			
			this.masters[Game.ITEM_BEACON] = new BeaconMaster(binder, this);
			this.masters[Game.ITEM_CHARACTER] = new CharacterMaster(binder, this, status);
			this.masters[Game.ITEM_SHARD] = new ShardMaster(binder, this);
			this.masters[Game.ITEM_THE_GOAL] = new TheGoalMaster(binder, this);
		}
		
		public function newGame():void
		{
			this.items = new Array();
			
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
		
		public function gameFrame(frame:int):void
		{
			var i:int, j:int;
			var item:PuppetBase;
			
			
			var center:ICoordinated = this.status.getLocationOfHero();
			
			const tlcX:int = center.x - Game.ACTION_RADIUS;
			const tlcY:int = center.y - Game.ACTION_RADIUS;
			
			const brcX:int = center.x + Game.ACTION_RADIUS + 1;
			const brcY:int = center.y + Game.ACTION_RADIUS + 1;
			
			for (j = tlcY; j < brcY; j++)
			{				
				for (i = tlcX; i < brcX; i++)
				{
					item = this.findObjectByCell(i, j);
					
					if (item)
					{
						item.tickPassed();
						//TODO: must call it on everyone who needs that
						
						if (frame == Game.FRAME_TO_ACT)
						{
							item._master.actOn(item);
						}
					}
				}
			}
		}
		
		public function quitGame():void
		{
			this.items = null;
		}
		
		
		
		internal function addItem(item:PuppetBase):void
		{
			if (this.items[item.x + item.y * Game.MAP_WIDTH])
				throw new Error();
			this.items[item.x + item.y * Game.MAP_WIDTH] = item;
		}
		
		internal function removeItem(item:PuppetBase):void
		{
			this.items[item.x + item.y * Game.MAP_WIDTH] = null;
		}
		//TODO: распутай это безумие, и можно будет приделать многоклеточники
		//      собственно, разумно сдизайнить класс заново. тут же ад какой-то, ну.
		
		
		public function findObjectByCell(x:int, y:int):PuppetBase
		{
			x = normalize(x);
			y = normalize(y);
			
			var item:PuppetBase = this.items[x + y * Game.MAP_WIDTH];
			
			return item;
		}
	}

}