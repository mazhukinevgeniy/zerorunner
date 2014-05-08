package model.metric 
{
	
	public class DCellXY extends XYPairBase
	{
		
		public function DCellXY(x:int, y:int) 
		{
			this._x = x; this._y = y;
		}
		
		public function get length():int
		{
			return Math.abs(this._x) + Math.abs(this._y);
		}
	}

}