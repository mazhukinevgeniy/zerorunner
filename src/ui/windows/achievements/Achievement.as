package ui.windows.achievements 
{
	import data.viewers.AchievementViewer;
	
	public class Achievement
	{
		private static const BASE_DATA:int = 0;
		
		private var _position:int;
		private var _unlocked:Boolean;
		private var _enabledSkin:String;
		private var _disabledSkin:String;
		private var _description:String;
		
		private var save:AchievementViewer;
		
		public function Achievement(data:Vector.<Object>) 
		{
			this.save = save;
			
			this.initialize(data);
		}
		
		private function initialize(data:Vector.<Object>):void
		{
			var radius:int = 15;
			var unlocked:Boolean;
			var enabledSkin:String = "ground";
			var disabledSkin:String = "unimplemented";
			var description:String = "this is achievement about distance - " + String(data[1].y) + "\n\n"+ String(data[Achievement.BASE_DATA].x);
			
			if (data[Achievement.BASE_DATA].y == 0) unlocked = false;
			else unlocked = true;
			
			this._position = data[Achievement.BASE_DATA].x;
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