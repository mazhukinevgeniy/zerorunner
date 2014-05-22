package model.items.concrete 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import model.interfaces.IScene;
	import model.items.ItemBase;
	import model.items.Items;
	import model.items.structs.ItemParams;
	import model.status.StatusReporter;
	import utils.getCellId;
	import utils.isCellSolid;
	
	public class ItemSpawner implements INewGameHandler
	{		
		private var status:StatusReporter;
		private var scene:IScene;
		
		private var itemParams:ItemParams;
		
		public function ItemSpawner(binder:IBinder, items:Items, status:StatusReporter) 
		{
			this.itemParams = new ItemParams();
			
			this.itemParams.binder = binder;
			this.itemParams.items = items;
			
			this.status = status;
			this.scene = binder.scene;
			
			binder.notifier.addObserver(this);
		}
		
		public function newGame():void
		{
			var map:XML = MapXML.getOne();
			var itemCodes:Array = MapXML.getItemCodes();
			
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
					this.createPassiveItem(Game.ITEM_THE_GOAL, x, y, 1, 1);
				else if (type == Game.ITEM_SHARD)
					this.createShard(x, y);
				else if (type == Game.ITEM_BEACON)
					this.createPassiveItem(Game.ITEM_BEACON, x, y, 1, 1);
				else if (type == Game.ITEM_THE_SPAWN)
					this.createPassiveItem(Game.ITEM_THE_SPAWN, x, y, 3, 3);
			}
		}
		
		private function createPassiveItem(type:int, x:int, y:int,
		                                   width:int, height:int):void
		{
			this.setParams(x, y, width, height);
			
			new PassiveItem(type, this.itemParams);
		}
		
		private function createCharacter(x:int, y:int):void
		{
			this.setParams(x, y, 1, 1);
			
			var hero:ItemBase = new Character(this.itemParams);
			
			this.status.newHero(hero);
		}
		
		
		public function createShard(x:int, y:int):void
		{
			if (isCellSolid(this.scene.getSceneCell(getCellId(x, y))))
			{
				this.setParams(x, y, 1, 1);
				
				new Shard(this.itemParams);
			}
		}
		
		
		private function setParams(x:int, y:int, width:int, height:int):void
		{
			this.itemParams.x = x;
			this.itemParams.y = y - height + 1;
			
			this.itemParams.width = width;
			this.itemParams.height = height;
		}
	}

}