package game.data 
{
	
	public class LevelConfiguration implements IGame
	{
		private var _width:int;
		private var _level:int;
		
		public function LevelConfiguration(current:IGame) 
		{
			if (current)
			{
				this._width = 1;
				//1 + current.mapWidth;
				this._level = current.level + 1;
			}
			else
			{
				this._level = 1;
				this._width = 1;
			}
		}
		
		
		public function get mapWidth():int
		{
			return this._width;
		}
		
		public function get level():int
		{
			return this._level;
		}
	}

}