package model 
{
	import assets.xml.MapXML;
	import binding.IBinder;
	import controller.observers.IGameFrameHandler;
	import controller.observers.INewGameHandler;
	import model.interfaces.ICollectibles;
	import model.interfaces.IStatus;
	import model.metric.ICoordinated;
	import model.utils.normalize;
	
	internal class Collectibles implements ICollectibles, INewGameHandler, IGameFrameHandler
	{
		private var status:IStatus;
		
		private var collectibles:Array;
		
		public function Collectibles(binder:IBinder) 
		{
			this.status = binder.gameStatus;
			
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
		
		public function gameFrame(frame:int):void
		{
			if (frame == Game.FRAME_UNUSED_FRAME_1)
			{
				var char:ICoordinated = this.status.getLocationOfHero();
				var key:int = char.x + char.y * Game.MAP_WIDTH;
				
				if (this.collectibles[key] == Game.COLLECTIBLE_ONE)
				{
					this.collectibles[key] = Game.COLLECTIBLE_NONE;
				}
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