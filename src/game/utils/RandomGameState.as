package game.utils 
{
	import game.IGame;
	
	public class RandomGameState implements IGame
	{
		private var _width:int;
		
		public function RandomGameState(current:IGame) 
		{
			this._width = 1 + current.mapWidth * (Math.random() + 0.5);
		}
		
		public function get mapWidth():int
		{
			return this._width;
		}
	}

}