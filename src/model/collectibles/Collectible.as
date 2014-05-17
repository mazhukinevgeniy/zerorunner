package model.collectibles 
{
	
	public class Collectible 
	{
		private var _type:int;
		private var _unmet:Boolean;
		
		public function Collectible(type:int, unmet:Boolean) 
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
	}

}