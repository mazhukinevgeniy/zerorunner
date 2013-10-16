package data.structs 
{
	
	public class PreferencesInfo
	{
		private var _mute:Boolean;
		
		public function PreferencesInfo(mute:Boolean) 
		{
			this._mute = mute;
		}
		
		public function get mute():Boolean
		{
			return this._mute;
		}
	}

}