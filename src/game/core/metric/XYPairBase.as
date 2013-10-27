package game.core.metric 
{
	
	internal class XYPairBase
	{
		internal var _x:int, _y:int;
		
		public function XYPairBase() 
		{
			
		}
		
		public function setValue(x:int, y:int):void
		{
			this._x = x;
			this._y = y;
		}
		
		public function get x():int { return this._x; }
		public function get y():int { return this._y; }
	}

}