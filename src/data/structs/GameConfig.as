package data.structs 
{
	
	public class GameConfig 
	{
		private var _width:int;
		private var _junks:int;
		private var _goal:int;
		
		private var _level:int;
		private var _numberOfDroids:int;
		
		public function GameConfig(width:int, junks:int, goal:int, level:int, droids:int) 
		{
			this._width = width;
			this._junks = junks;
			this._goal = goal;
			
			this._level = level;
			this._numberOfDroids = droids;
		}
		
		public function get width():int { return this._width; }
		public function get junks():int { return this._junks; }
		public function get goal():int { return this._goal; }
		
		
		
		
		/**
		 * Please note: level must be natural (i.e. it's an integer > 0)
		 */
		public function beacon(level:int):int
		{
			//return this.localSave.data["beaconProgress" + String(level)];
			return Game.NO_BEACON; //TODO: implement
		}
		
		public function get level():int { return this._level; }
		public function get numberOfDroids():int { return this._numberOfDroids; }
	}

}