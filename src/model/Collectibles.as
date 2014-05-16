package model 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import controller.observers.INewGameHandler;
	import model.interfaces.ICollectible;
	import model.utils.normalize;
	
	internal class Collectibles implements ICollectible, INewGameHandler
	{
		private var collectibles:Array;
		
		public function Collectibles(binder:IBinder) 
		{
			
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
				
				this.collectibles[x + y * Game.MAP_WIDTH] = Game.COLLECTIBLE_ONE;
			}
		}
		
		public function findCollectible(x:int, y:int):int
		{
			x = normalize(x);
			y = normalize(y);
			
			return this.collectibles[x + y * Game.MAP_WIDTH] ? 
				Game.COLLECTIBLE_ONE : Game.COLLECTIBLE_NONE;
		}
	}

}