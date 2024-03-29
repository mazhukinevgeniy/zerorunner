package model.metric 
{
	
	public class CellXY extends XYPairBase implements ICoordinated
	{
		
		public function CellXY(x:int, y:int) 
		{
			this._x = x; this._y = y;
		}
		
		public function isEqualTo(coordinates:ICoordinated):Boolean
		{
			return (this._x == coordinates.x) && (this._y == coordinates.y);
		}
	}

}