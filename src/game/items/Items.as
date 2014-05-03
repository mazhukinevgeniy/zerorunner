package game.items 
{
	import data.IStatus;
	import data.StatusReporter;
	import game.GameElements;
	import game.interfaces.IRestorable;
	import game.items.beacon.BeaconMaster;
	import game.items.character.CharacterMaster;
	import game.items.checkpoint.CheckpointMaster;
	import game.items.shard.ShardMaster;
	import game.items.the_goal.TheGoalMaster;
	import game.metric.DCellXY;
	import game.metric.ICoordinated;
	import game.projectiles.Projectiles;
	import utils.MapXML;
	import utils.updates.update;
	
	use namespace items_internal;
	
	public class Items implements IRestorable
	{
		private var activeItems:Array;
		private var passiveItems:Array;
		
		private var moved:Vector.<PuppetBase>;
		
		private var masters:Vector.<MasterBase>;
		
		private var status:IStatus;
		
		public function Items(elements:GameElements, status:StatusReporter,
		                                             projectiles:Projectiles) 
		{
			this.status = elements.status;
			
			elements.restorer.addSubscriber(this);
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			this.masters = new Vector.<MasterBase>(Game.NUMBER_OF_ITEM_TYPES, true);
			
			this.masters[Game.ITEM_BEACON] = new BeaconMaster(elements);
			this.masters[Game.ITEM_CHARACTER] = new CharacterMaster(elements, status);
			this.masters[Game.ITEM_CHECKPOINT] = new CheckpointMaster(elements, projectiles);
			this.masters[Game.ITEM_SHARD] = new ShardMaster(elements);
			this.masters[Game.ITEM_THE_GOAL] = new TheGoalMaster(elements);
			
			this.moved = new Vector.<PuppetBase>();
		}
		
		public function restore():void
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
		
		update function numberedFrame(key:int):void
		{
			var i:int, j:int;
			var item:PuppetBase;
			
			for each (var pup:PuppetBase in this.activeItems)
				pup.tickPassed();
			
			if (key == Game.FRAME_TO_ACT)
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
		
		update function quitGame():void
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