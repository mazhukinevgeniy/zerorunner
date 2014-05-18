package model.collectibles 
{
	import model.metric.ICoordinated;
	
	public class Collectible implements ICoordinated
	{
		private var _type:int;
		private var _unmet:Boolean;
		
		private var _x:int;
		private var _y:int;
		
		public function Collectible(type:int, unmet:Boolean, x:int, y:int) 
		{
			this._type = type;
			this._unmet = unmet;
		}
		
		public function get type():int
		{
			return this._type;
		}
		
		public function get unmet():Boolean
		{
			return this._unmet;
		}
		
		public function get x():int
		{
			return this._x;
		}
		
		public function get y():int
		{
			return this._y;
		}
	}

}