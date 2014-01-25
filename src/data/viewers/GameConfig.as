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
		
		public function get numberOfDroids():int { return this.save["activeDroids"]; }
		public function get cloudiness():int { return this.save["cloudiness"]; }
		
		
	}

}