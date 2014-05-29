package model.collectibles 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import controller.interfaces.IGameController;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import model.interfaces.ICollectibles;
	import model.interfaces.ISave;
	import model.interfaces.IStatus;
	import model.metric.ICoordinated;
	import utils.getCellId;
	
	public class Collectibles implements ICollectibles, INewGameHandler, IGameFrameHandler
	{
		private var status:IStatus;
		private var save:ISave;
		
		private var controller:IGameController;
		
		private var collectibles:Array;
		
		public function Collectibles(binder:IBinder) 
		{
			this.status = binder.gameStatus;
			this.save = binder.save;
			
			this.controller = binder.gameController;
			
			binder.notifier.addObserver(this);
		}
		
		public function newGame():void
		{
			this.collectibles = new Array();
			
			
			var map:XML = MapXML.getOne();
			
			if (map.objectgroup[3].@name != "Collectibles")
				throw new Error("Map incompatible");
			
			var collectibles:XMLList = map.objectgroup[3].object;
			
			for (var i:int = 0; i < collectibles.length(); i++)
			{
				var x:int = collectibles[i].@x / View.CELL_WIDTH;
				var y:int = collectibles[i].@y / View.CELL_HEIGHT;
				
				var cellId:int = getCellId(x, y);
				
				var type:int = collectibles[i].@type;
				var unmet:Boolean = !this.save.getCollectibleFound(type);
				
				this.collectibles[cellId] = new Collectible(type, unmet, x, y);
			}
		}
		
		public function gameFrame():void
		{
			var char:ICoordinated = this.status.getLocationOfHero();
			var cellId:int = getCellId(char.x, char.y);
			
			var coll:Collectible = this.collectibles[cellId];
			
			if (coll)
			{
				this.controller.setCollectibleFound(coll);
				this.collectibles[cellId] = null;
			}
		}
		
		public function findCollectible(cellId:int):Collectible
		{
			return this.collectibles[cellId];
		}
	}

}