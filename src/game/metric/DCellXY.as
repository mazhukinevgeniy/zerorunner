package game.metric 
{
	
	public class DCellXY extends XYPairBase
	{
		
		public function DCellXY(x:int, y:int) 
		{
			this._x = x; this._y = y;
		}
		
		public function invert():DCellXY
		{
			return new DCellXY(- this._x, - this._y);
		}
	}

}