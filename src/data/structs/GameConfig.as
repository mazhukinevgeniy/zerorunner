package data.structs 
{
	
	public class GameConfig 
	{
		private var _width:int;
		private var _junks:int;
		private var _goal:int;
		
		
		public function GameConfig(width:int, junks:int, goal:int) 
		{
			this._width = width;
			this._junks = junks;
			this._goal = goal;
		}
		
		public function get width():int { return this._width; }
		public function get junks():int { return this._junks; }
		public function get goal():int { return this._goal; }
		
		
	}

}