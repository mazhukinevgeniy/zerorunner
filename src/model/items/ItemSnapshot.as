package model.items 
{
	
	public class ItemSnapshot 
	{
		internal var _type:int;
		
		internal var _x:Number;
		internal var _y:Number;
		
		internal var _width:int;
		internal var _height:int;
		
		internal var _occ:int;
		internal var _prog:Number;
		
		internal var _direction:int;
		
		
		public function ItemSnapshot() 
		{
			
		}
		
		public function get type():int { return this._type; }
		
		public function get x():Number { return this._x; }
		public function get y():Number { return this._y; }
		
		public function get width():int { return this._width; }
		public function get height():int { return this._height; }
		
		public function get occupation():int { return this._occ; }
		public function get progress():Number { return this._prog; }
		
		public function get direction():int { return this._direction; }
		
		
		
		public function isFree():Boolean
		{
			return this._occ == Game.OCCUPATION_FREE;
		}
	}

}