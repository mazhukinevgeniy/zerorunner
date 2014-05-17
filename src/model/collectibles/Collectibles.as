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
	import model.utils.normalize;
	
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
				
				var key:int = x + y * Game.MAP_WIDTH;
				
				var type:int = collectibles[i].@type;
				var unmet:Boolean = !this.save.getCollectibleFound(type);
				
				this.collectibles[key] = new Collectible(type, unmet);
			}
		}
		
		public function gameFrame(frame:int):void
		{
			if (frame == Game.FRAME_UNUSED_FRAME_1)
			{
				var char:ICoordinated = this.status.getLocationOfHero();
				var key:int = char.x + char.y * Game.MAP_WIDTH;
				
				var coll:Collectible = this.collectibles[key];
				
				if (coll)
				{
					this.controller.setCollectibleFound(coll);
					this.collectibles[key] = null;
				}
			}
		}
		
		public function findCollectible(x:int, y:int):Collectible
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.collectibles[x + y * Game.MAP_WIDTH];
		}
	}

}