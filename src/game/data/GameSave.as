package game.data 
{
	import utils.SaveBase;
	
	public class GameSave extends SaveBase implements IGame
	{
		
		public function GameSave() 
		{
			
		}
		
		override protected function checkLocalSave():void
		{
			if (!this.localSave.data.game)
				this.localSave.data.game = new Object();
			
			if (!this.localSave.data.game.width)
			{
				this.localSave.data.game.width = 1;
			}
			
			if (!this.localSave.data.game.level)
			{
				this.localSave.data.game.level = 1;
			}
			
			if (!this.localSave.data.game.beacons)
			{
				this.localSave.data.game.beacons = new Array();
			}
			
			if (!this.localSave.data.game.droids)
			{
				this.localSave.data.game.droids = 0;
			}
		}
		
		
		public function get mapWidth():int
		{
			return this.localSave.data.game.width;
		}
		
		public function set mapWidth(value:int):void
		{
			this.localSave.data.game.width = value;
		}
		
		
		public function get level():int
		{
			return this.localSave.data.game.level;
		}
		
		public function set level(value:int):void
		{
			this.localSave.data.game.level = value;
		}
		
		
		public function getBeacon(level:int):int
		{
			if (level < 1)
				throw new Error();
			
			return this.localSave.data.game.beacons[level];
		}
		
		public function setBeacon(level:int, value:int):void
		{
			if (level < 1)
				throw new Error();
			
			this.localSave.data.game.beacons[level] = value;
		}
		
		public function get numberOfDroids():int
		{
			return this.localSave.data.game.droids;
		}
		
		public function set numberOfDroids(value:int):void
		{
			this.localSave.data.game.droids = value;
		}
	}

}