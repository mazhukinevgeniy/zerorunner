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
	import game.points.IPointCollector;
	import utils.updates.update;
	
	use namespace items_internal;
	
	public class Items
	{
		private var points:IPointCollector;
		
		private var items:Array;
		private var width:int;
		
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
			new JunkMaster(elements);
			
			this.moved = new Vector.<PuppetBase>();
		}
		
		update function prerestore(config:GameConfig):void
		{
			this.width = Game.MAP_WIDTH + 2 * Game.BORDER_WIDTH;
			this.items = new Array();
		}
		
		update function numberedFrame(key:int):void
		{
			var i:int, j:int;
			var item:PuppetBase;
			
			if (key == Game.FRAME_TO_ACT)
			{
				for each (var pup:PuppetBase in this.items)
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
						item = this.findObjectByCell(i, j);
						
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
			else if (key == Game.FRAME_TO_CLEAR_BORDERS)
			{
				const DWIDTH:int = Game.BORDER_WIDTH / 2;
				
				for (i = 0; i < this.width; i++)
					for (j = 0; j < DWIDTH; j++)
					{
						item = this.findObjectByCell(i, j);
						
						if (item)
							item.forceDestruction();
						
						item = this.findObjectByCell(i, this.width - (j + 1));
						
						if (item)
							item.forceDestruction();
					}
				for (i = 0; i < DWIDTH; i++)
					for (j = DWIDTH; j < this.width - DWIDTH; j++)
					{
						item = this.findObjectByCell(i, j);
						
						if (item)
							item.forceDestruction();
						
						item = this.findObjectByCell(this.width - (i + 1), j);
						
						if (item)
							item.forceDestruction();
					}
			}
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
		
		
		internal function removeItem(item:PuppetBase):void
		{
			delete this.items[item.x + item.y * this.width];
		}
		
		
		
		public function findObjectByCell(x:int, y:int):PuppetBase
		{
			return this.items[x + y * this.width];
		}
	}

}