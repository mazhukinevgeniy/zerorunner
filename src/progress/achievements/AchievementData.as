package progress.achievements 
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class AchievementData 
	{
		private var _position:int;
		private var _unlocked:Boolean;
		private var _enabledSkin:String;
		private var _disabledSkin:String;
		private var _description:String;
		
		
		public function AchievementData(position:int, unlocked:Boolean = false, enabledSkin:String = "ground", disabledSkin:String = "unimplemented", description:String = "this is achievement") 
		{
			var radius:int = 15;
			
			this._position = position;
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