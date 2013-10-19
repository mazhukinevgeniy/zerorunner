package ui.windows.achievements 
{
	import data.viewers.AchievementViewer;
	
	public class AchievementData 
	{
		private var _position:int;
		private var _unlocked:Boolean;
		private var _enabledSkin:String;
		private var _disabledSkin:String;
		private var _description:String;
		
		private var save:AchievementViewer;
		
		public function AchievementData(id:int, save:AchievementViewer) 
		{
			this.save = save;
			
			this.reset(id);
		}
		
		internal function reset(id:int):void
		{
			var radius:int = 15;
			
			var unlocked:Boolean = false;
			var enabledSkin:String = "ground";
			var disabledSkin:String = "unimplemented";
			var description:String = "this is achievement \n this is achievement" +
									 "\n this is achievement\n this is achievement" +
									 "this is achievement";
			
			this._position = id;
			this._unlocked = unlocked;
			this._enabledSkin = enabledSkin;
			this._disabledSkin = disabledSkin;
			this._description = description;
		}
		
		public function get position():int
		{
			return this._position;
		}
		
		public function get unlocked():Boolean
		{
			return this._unlocked;
		}
		
		public function get enabledSkin():String
		{
			return this._enabledSkin;
		}
		
		public function get disabledSkin():String
		{
			return this._disabledSkin;
		}
		
		public function get description():String
		{
			return this._description;
		}
		
		
	}

}