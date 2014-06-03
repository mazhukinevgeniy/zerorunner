package model.collectibles 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import events.GlobalEvent;
	import model.interfaces.ICollectibles;
	import model.interfaces.ISave;
	import model.interfaces.IStatus;
	import model.metric.ICoordinated;
	import starling.events.EventDispatcher;
	import utils.getCellId;
	
	public class Collectibles implements ICollectibles
	{
		private var status:IStatus;
		private var save:ISave;
		
		private var dispatcher:EventDispatcher;
		
		private var collectibles:Array;
		
		public function Collectibles(binder:IBinder) 
		{
			this.status = binder.gameStatus;
			this.save = binder.save;
			
			this.dispatcher = binder.eventDispatcher;
			
			this.dispatcher.addEventListener(GlobalEvent.NEW_GAME, this.newGame);
			this.dispatcher.addEventListener(GlobalEvent.GAME_FRAME, this.gameFrame);
		}
		
		private function newGame():void
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
		
		private function gameFrame():void
		{
			var char:ICoordinated = this.status.getLocationOfHero();
			var cellId:int = getCellId(char.x, char.y);
			
			var coll:Collectible = this.collectibles[cellId];
			
			if (coll)
			{
				this.dispatcher.dispatchEventWith(GlobalEvent.COLLECTIBLE_FOUND,
				                                  false,
												  coll);
				this.collectibles[cellId] = null;
			}
		}
		
		public function findCollectible(cellId:int):Collectible
		{
			return this.collectibles[cellId];
		}
	}

}