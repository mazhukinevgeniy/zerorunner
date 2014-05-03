package data 
{
	
	public class NumericalDxyHelper 
	{
		private var _x:Number, _y:Number;
		
		public function NumericalDxyHelper() 
		{
			
		}
		
		internal function setValue(x:Number, y:Number):void
		{
			this._x = x;
			this._y = y;
		}
		
		public function get dx():Number
		{
			return this._x;
		}
		
		public function get dy():Number
		{
			return this._y;
		}
	}

}