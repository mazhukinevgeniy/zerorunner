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
	import model.items.checkpoint.CheckpointMaster;
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
		private var activeItems:Array;
		private var passiveItems:Array;
		
		private var moved:Vector.<PuppetBase>;
		
		private var masters:Vector.<MasterBase>;
		
		private var status:IStatus;
		
		public function Items(binder:IBinder, status:StatusReporter) 
		{
			this.status = status;
			
			binder.notifier.addObserver(this);
			
			this.masters = new Vector.<MasterBase>(Game.NUMBER_OF_ITEM_TYPES, true);
			
			this.masters[Game.ITEM_BEACON] = new BeaconMaster(binder, this);
			this.masters[Game.ITEM_CHARACTER] = new CharacterMaster(binder, this, status);
			this.masters[Game.ITEM_CHECKPOINT] = new CheckpointMaster(binder, this);
			this.masters[Game.ITEM_SHARD] = new ShardMaster(binder, this);
			this.masters[Game.ITEM_THE_GOAL] = new TheGoalMaster(binder, this);
			
			this.moved = new Vector.<PuppetBase>();
		}
		
		public function newGame():void
		{
			this.activeItems = new Array();
			this.passiveItems = new Array();
			
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
				else if (name == "checkpoint")
					itemCodes[i + 1] = Game.ITEM_CHECKPOINT;
			}
			
			var objects:XMLList = map.objectgroup[0].object;
			const LENGTH:int = objects.length();
			
			for (var j:int = 0; j < LENGTH; j++)
			{
				var type:int = itemCodes[objects[j].@gid];
				var x:int = int(objects[j].@x) / Game.CELL_WIDTH;
				var y:int = int(objects[j].@y) / Game.CELL_HEIGHT;
				
				this.masters[type].spawnPuppet(x, y);
			}
		}
		
		public function gameFrame(frame:int):void
		{
			var i:int, j:int;
			var item:PuppetBase;
			
			for each (var pup:PuppetBase in this.activeItems)
				pup.tickPassed();
			
			if (frame == Game.FRAME_TO_ACT)
			{
				var center:ICoordinated = this.status.getLocationOfHero();
				
				const tlcX:int = center.x - 20;
				const tlcY:int = center.y - 20;
				
				//TODO: get rid of the hardcode
				const brcX:int = center.x + 20;
				const brcY:int = center.y + 20;
				
				this.moved.length = 0;
				
				for (j = tlcY; j < brcY; j++)
				{				
					for (i = tlcX; i < brcX; i++)
					{
						item = this.findActiveObjectByCell(i, j);
						
						if (item && this.moved.indexOf(item) == -1)
						{
							item._master.actOn(item);
							this.moved.push(item);
						}
					}
				}
				
			}
		}
		
		public function quitGame():void
		{
			this.activeItems = null;
			this.passiveItems = null;
		}
		
		
		
		internal function addActiveItem(item:PuppetBase):void
		{
			if (this.activeItems[item.x + item.y * Game.MAP_WIDTH] ||
				this.passiveItems[item.x + item.y * Game.MAP_WIDTH])
				throw new Error();
			this.activeItems[item.x + item.y * Game.MAP_WIDTH] = item;
		}
		
		internal function addPassiveItem(item:PuppetBase):void
		{
			if (this.activeItems[item.x + item.y * Game.MAP_WIDTH] ||
				this.passiveItems[item.x + item.y * Game.MAP_WIDTH])
				throw new Error();
			this.passiveItems[item.x + item.y * Game.MAP_WIDTH] = item;
		}
		
		internal function activateItem(item:PuppetBase):void
		{
			this.passiveItems[item.x + item.y * Game.MAP_WIDTH] = null;
			this.activeItems[item.x + item.y * Game.MAP_WIDTH] = item;
		}
		
		internal function deactivateItem(item:PuppetBase):void
		{
			this.passiveItems[item.x + item.y * Game.MAP_WIDTH] = item;
			this.activeItems[item.x + item.y * Game.MAP_WIDTH] = null;
		}
		
		internal function removeItem(item:PuppetBase):void
		{
			delete this.passiveItems[item.x + item.y * Game.MAP_WIDTH];
			delete this.activeItems[item.x + item.y * Game.MAP_WIDTH];
		}
		
		
		
		public function findAnyObjectByCell(x:int, y:int):PuppetBase
		{
			x = normalize(x);
			y = normalize(y);
			
			var item:PuppetBase = this.activeItems[x + y * Game.MAP_WIDTH];
			
			if (item == null)
				item = this.passiveItems[x + y * Game.MAP_WIDTH];
			
			return item;
		}
		
		public function findActiveObjectByCell(x:int, y:int):PuppetBase
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.activeItems[x + y * Game.MAP_WIDTH];
		}
	}

}