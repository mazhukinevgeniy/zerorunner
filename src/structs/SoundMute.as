package structs 
{
	
	public class SoundMute 
	{
		private var _type:int;
		private var _value:Boolean;
		
		public function SoundMute(type:int, value:Boolean) 
		{
			this._type = type;
			this._value = value;
		}
		
		public function get type():int
		{
			return this._type;
		}
		
		public function get value():Boolean
		{
			return this._value;
		}
		
	}

}