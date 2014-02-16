package game.items 
{
	import data.viewers.GameConfig;
	import game.core.metric.DCellXY;
	import game.core.metric.ICoordinated;
	import game.GameElements;
	import game.items.beacon.BeaconMaster;
	import game.items.character.CharacterMaster;
	import game.items.shard.ShardMaster;
	//import game.items.droid.DroidMaster;
	import game.points.IPointCollector;
	import utils.updates.update;
	
	use namespace items_internal;
	
	public class Items
	{
		private var points:IPointCollector;
		
		private var activeItems:Array;
		private var passiveItems:Array;
		
		private var moved:Vector.<PuppetBase>;
		
		public function Items(elements:GameElements) 
		{
			this.points = elements.pointsOfInterest;
			
			elements.flow.workWithUpdateListener(this);
			elements.flow.addUpdateListener(Update.prerestore);
			elements.flow.addUpdateListener(Update.numberedFrame);
			elements.flow.addUpdateListener(Update.quitGame);
			
			new CharacterMaster(elements);
			new BeaconMaster(elements);
			//new DroidMaster(elements); //TODO: see DroidMaster.as
			new ShardMaster(elements);
			
			this.moved = new Vector.<PuppetBase>();
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.activeItems = new Array();
			this.passiveItems = new Array();
		}
		
		update function numberedFrame(key:int):void
		{
			var i:int, j:int;
			var item:PuppetBase;
			
			if (key == Game.FRAME_TO_ACT)
			{
				for each (var pup:PuppetBase in this.activeItems)
					pup.tickPassed(); //TODO: check if troublesome
				
				var center:ICoordinated = this.points.getCharacter();
				
				const tlcX:int = center.x - 20;
				const tlcY:int = center.y - 20;
				
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
				
				var others:Vector.<PuppetBase> = this.points.getAlwaysActives();
				var length:int = others ? others.length : 0;
				
				for (i = 0; i < length; i++)
				{
					item = others[i];
					
					if (this.moved.indexOf(item) == -1)
						item._master.actOn(item);
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
			if (this.activeItems[item.x + item.y * Game.MAP_WIDTH] ||
				!this.passiveItems[item.x + item.y * Game.MAP_WIDTH])
				throw new Error();
			
			this.passiveItems[item.x + item.y * Game.MAP_WIDTH] = null;
			this.activeItems[item.x + item.y * Game.MAP_WIDTH] = item;
		}
		
		internal function deactivateItem(item:PuppetBase):void
		{
			if (!this.activeItems[item.x + item.y * Game.MAP_WIDTH] ||
				this.passiveItems[item.x + item.y * Game.MAP_WIDTH])
				throw new Error();
			
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