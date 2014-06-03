package structs 
{
	
	public class SoundVolume 
	{
		private var _type:int;
		private var _value:Number;
		
		public function SoundVolume(type:int, value:Number) 
		{
			this._type = type;
			this._value = value;
		}
		
		public function get type():int
		{
			return this._type;
		}
		
		public function get value():Number
		{
			return this._value;
		}
	}

}