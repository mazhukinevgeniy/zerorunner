package game.metric 
{
	
	public class CellXY extends XYPairBase implements ICoordinated
	{
		
		public function CellXY(x:int, y:int) 
		{
			this._x = x; this._y = y;
		}
		
		public function setValue(x:int, y:int):void
		{
			this._x = x;
			this._y = y;
		}
		
		public function isEqualTo(coordinates:ICoordinated):Boolean
		{
			return (this._x == coordinates.x) && (this._y == coordinates.y);
		}
	}

}