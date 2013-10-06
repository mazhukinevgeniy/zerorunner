package game.data 
{
	import utils.SaveBase;
	
	public class GameSave extends SaveBase implements IGame
	{
		private const defaultValues:Object = 
		{
			gameCurrentWidth: 1,
			gameCurrentLevel: 1,
			gameCurrentJunks: 0,
			gameActiveDroids: 0
		}
		
		public function GameSave() 
		{
			
		}
		
		override protected function checkLocalSave():void
		{
			for (var value:String in this.defaultValues)
			{
				if (!this.localSave.data[value])
					this.localSave.data[value] = this.defaultValues[value];
			}
			
			if (!this.localSave.data.beaconProgress)
			{
				this.localSave.data.beaconProgress = new Array();
			}
		}
		
		
		public function get mapWidth():int { return this.localSave.data.gameCurrentWidth; }
		public function set mapWidth(value:int):void { this.localSave.data.gameCurrentWidth = value; }
		
		public function get level():int { return this.localSave.data.gameCurrentLevel; }
		public function set level(value:int):void { this.localSave.data.gameCurrentLevel = value; }
		
		public function get numberOfDroids():int { return this.localSave.data.gameActiveDroids; }
		public function set numberOfDroids(value:int):void { this.localSave.data.gameActiveDroids = value; }
		
		public function get numberOfJunks():int { return this.localSave.data.gameCurrentJunks; }
		public function set numberOfJunks(value:int):void { this.localSave.data.gameCurrentJunks = value; }
		
		
		public function getBeacon(level:int):int
		{
			if (level < 1)
				throw new Error();
			
			return this.localSave.data.beaconProgress[level];
		}
		
		public function setBeacon(level:int, value:int):void
		{
			if (level < 1)
				throw new Error();
			
			this.localSave.data.beaconProgress[level] = value;
		}
	}

}