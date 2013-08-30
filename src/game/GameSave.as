package game 
{
	import utils.SaveBase;
	
	internal class GameSave extends SaveBase implements IGame
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
		}
		
		
		public function get mapWidth():int
		{
			return this.localSave.data.game.width;
			//return 9;
			//TODO: must work with 240;
		}
		
		public function set mapWidth(value:int):void
		{
			this.localSave.data.game.width = value;
		}
	}

}