package data.viewers 
{
	import flash.utils.Proxy;
	
	public class GameConfig 
	{
		private var save:Proxy;
		
		public function GameConfig(save:Proxy) 
		{
			this.save = save;
		}
		
		public function get width():int { return this.save["width"]; }
		public function get junks():int { return this.save["junks"]; }
		public function get goal():int { return this.save["goal"]; }
		public function get level():int { return this.save["level"]; }
		public function get numberOfDroids():int { return this.save["activeDroids"]; }
		
		
		
		
		/**
		 * Please note: level must be natural (i.e. it's an integer > 0)
		 */
		public function beacon(level:int):int
		{
			return this.save["beacon" + String(level)];
		}
		
	}

}