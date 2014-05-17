package model.collectibles 
{
	
	public class Collectible 
	{
		private var _type:int;
		
		public function Collectible(type:int) 
		{
			this._type = type;
		}
		
		public function get type():int
		{
			return this._type;
		}
	}

}