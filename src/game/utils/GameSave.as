package game.utils 
{
	import game.IGame;
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
	}

}