package game.metric 
{
	
	public class CellXY extends XYPairBase
	{
		
		public function CellXY(x:int, y:int) 
		{
			this._x = x; this._y = y;
		}
		
		public function isEqualTo(coordinates:CellXY):Boolean
		{
			return (this._x == coordinates.x) && (this._y == coordinates.y);
		}
		
		public function applyChanges(changes:DCellXY):CellXY
		{
			this._x += changes.x;
			this._y += changes.y;
			
			return this;
		}
		public function setValue(x:int, y:int):void
		{
			this._x = x;
			this._y = y;
		}
		
		public function getCopy():CellXY
		{
			return new CellXY(this._x, this._y);
		}
		
		public function isOutOf(topLeft:CellXY, bottomRight:CellXY):Boolean
		{
			return this.x > bottomRight.x || 
				   this.x < topLeft.x || 
				   this.y > bottomRight.y || 
				   this.y < topLeft.y;
		}
	}

}